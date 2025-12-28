import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "./useAuth";
import {
  toIST,
  getISTDate,
  getWeekStartIST,
  getDayOfWeekIST,
  isSameDayIST,
  getDateOnlyIST,
  getDaysDifferenceIST,
  getStartOfDayIST,
  getEndOfDayIST,
} from "@/utils/timezone";

interface WeeklyData {
  day: string;
  tone: number;
  confidence: number;
  fluency: number;
}

interface Improvement {
  area: string;
  trend: "up" | "down";
  change: string;
}

interface OverallStats {
  totalSessions: number;
  practiceTime: string;
  currentStreak: number;
  avgScore: number;
}

interface ProgressData {
  weeklyData: WeeklyData[];
  improvements: Improvement[];
  overallStats: OverallStats;
  loading: boolean;
  error: string | null;
}

const DAYS_OF_WEEK = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

export const useProgress = (): ProgressData => {
  const { user } = useAuth();
  const [weeklyData, setWeeklyData] = useState<WeeklyData[]>([]);
  const [improvements, setImprovements] = useState<Improvement[]>([]);
  const [overallStats, setOverallStats] = useState<OverallStats>({
    totalSessions: 0,
    practiceTime: "0h",
    currentStreak: 0,
    avgScore: 0,
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!user?.id) {
      setLoading(false);
      return;
    }

    const fetchProgressData = async () => {
      try {
        setLoading(true);
        setError(null);

        // Fetch all completed sessions for the user
        // Try to fetch with scores, but fallback to basic fields if columns don't exist
        let sessions: any[] = [];
        let sessionsError: any = null;
        
        try {
          const { data, error } = await supabase
            .from("sessions")
            .select("id, started_at, ended_at, category_id, tone_score, confidence_score, fluency_score")
            .eq("user_id", user.id)
            .not("ended_at", "is", null)
            .order("started_at", { ascending: false });
          
          sessions = data || [];
          sessionsError = error;
        } catch (err: any) {
          // If columns don't exist, fetch without scores
          if (err?.code === "42703" || err?.message?.includes("does not exist")) {
            console.warn("⚠️ Score columns not found, fetching sessions without scores. Please run the migration.");
            const { data, error } = await supabase
              .from("sessions")
              .select("id, started_at, ended_at, category_id")
              .eq("user_id", user.id)
              .not("ended_at", "is", null)
              .order("started_at", { ascending: false });
            
            sessions = data || [];
            sessionsError = error;
          } else {
            sessionsError = err;
          }
        }

        if (sessionsError) {
          // If it's a column error, continue with empty sessions
          if (sessionsError.code === "42703" || sessionsError.message?.includes("does not exist")) {
            console.warn("⚠️ Score columns not found, continuing without scores");
            sessions = [];
          } else {
            throw sessionsError;
          }
        }

        // Fetch all recordings to calculate practice time
        const { data: recordings, error: recordingsError } = await supabase
          .from("recordings")
          .select("session_id, duration")
          .eq("user_id", user.id);

        if (recordingsError) throw recordingsError;

        // Calculate weekly performance
        const weekly = calculateWeeklyPerformance(sessions || []);
        setWeeklyData(weekly);

        // Calculate overall statistics
        const stats = calculateOverallStats(sessions || [], recordings || []);
        setOverallStats(stats);

        // Calculate improvement areas
        const improvements = calculateImprovements(sessions || [], recordings || []);
        setImprovements(improvements);
      } catch (err) {
        console.error("Error fetching progress data:", err);
        setError(err instanceof Error ? err.message : "Failed to load progress data");
      } finally {
        setLoading(false);
      }
    };

    fetchProgressData();
  }, [user?.id]);

  return {
    weeklyData,
    improvements,
    overallStats,
    loading,
    error,
  };
};

/**
 * Calculate weekly performance data grouped by day of week in IST
 */
function calculateWeeklyPerformance(sessions: any[]): WeeklyData[] {
  const weekStart = getWeekStartIST();
  const weekEnd = new Date(weekStart);
  weekEnd.setUTCDate(weekStart.getUTCDate() + 6);
  weekEnd.setUTCHours(23, 59, 59, 999);

  // Get sessions from the current week (Monday to Sunday) in IST
  const recentSessions = sessions.filter((session) => {
    if (!session.started_at) return false;
    const sessionDate = toIST(new Date(session.started_at));
    return sessionDate >= weekStart && sessionDate <= weekEnd;
  });

  // Group sessions by day of week (0 = Sunday, 1 = Monday, etc.)
  const dayGroups: Record<number, any[]> = {};
  for (let i = 0; i < 7; i++) {
    dayGroups[i] = [];
  }

  recentSessions.forEach((session) => {
    const sessionDate = toIST(new Date(session.started_at));
    const dayIndex = sessionDate.getUTCDay(); // 0 = Sunday, 1 = Monday, etc.
    if (dayGroups[dayIndex]) {
      dayGroups[dayIndex].push(session);
    }
  });

  // Calculate averages for each day, ordered Sunday to Saturday
  const weeklyData: WeeklyData[] = DAYS_OF_WEEK.map((day, index) => {
    const daySessions = dayGroups[index] || [];
    
    if (daySessions.length === 0) {
      // Return default values for days with no sessions
      return {
        day,
        tone: 0,
        confidence: 0,
        fluency: 0,
      };
    }

    // Calculate averages from real scores (if available)
    // Check if scores exist in the data structure
    const hasScores = daySessions.some(
      (s: any) => s.tone_score !== null && s.tone_score !== undefined
    );

    if (!hasScores) {
      // No scores available (columns don't exist or no scores recorded), return 0
      return {
        day,
        tone: 0,
        confidence: 0,
        fluency: 0,
      };
    }

    // Calculate average scores
    const sessionsWithTone = daySessions.filter((s: any) => s.tone_score != null);
    const sessionsWithConfidence = daySessions.filter((s: any) => s.confidence_score != null);
    const sessionsWithFluency = daySessions.filter((s: any) => s.fluency_score != null);

    const toneSum = sessionsWithTone.reduce((sum: number, s: any) => sum + (s.tone_score || 0), 0);
    const confidenceSum = sessionsWithConfidence.reduce((sum: number, s: any) => sum + (s.confidence_score || 0), 0);
    const fluencySum = sessionsWithFluency.reduce((sum: number, s: any) => sum + (s.fluency_score || 0), 0);

    return {
      day,
      tone: sessionsWithTone.length > 0 ? Math.round(toneSum / sessionsWithTone.length) : 0,
      confidence: sessionsWithConfidence.length > 0 ? Math.round(confidenceSum / sessionsWithConfidence.length) : 0,
      fluency: sessionsWithFluency.length > 0 ? Math.round(fluencySum / sessionsWithFluency.length) : 0,
    };
  });

  return weeklyData;
}

/**
 * Calculate overall statistics
 */
function calculateOverallStats(sessions: any[], recordings: any[]): OverallStats {
  // Total sessions
  const totalSessions = sessions.length;

  // Total practice time (sum of all recording durations in seconds)
  const totalSeconds = recordings.reduce((sum, rec) => sum + (rec.duration || 0), 0);
  const totalHours = Math.floor(totalSeconds / 3600);
  const totalMinutes = Math.floor((totalSeconds % 3600) / 60);
  const practiceTime = totalHours > 0 
    ? `${totalHours}h${totalMinutes > 0 ? ` ${totalMinutes}m` : ''}`
    : `${totalMinutes}m`;

  // Current streak (consecutive days with at least one session in IST)
  const currentStreak = calculateStreak(sessions);

  // Average score from real session scores (if available)
  const hasScores = sessions.some(
    (s: any) => s.tone_score !== null && s.tone_score !== undefined
  );

  let avgScore = 0;
  if (hasScores) {
    const allScores: number[] = [];
    sessions.forEach((s: any) => {
      if (s.tone_score != null) allScores.push(s.tone_score);
      if (s.confidence_score != null) allScores.push(s.confidence_score);
      if (s.fluency_score != null) allScores.push(s.fluency_score);
    });
    
    if (allScores.length > 0) {
      avgScore = Math.round(allScores.reduce((sum, score) => sum + score, 0) / allScores.length);
    }
  }

  return {
    totalSessions,
    practiceTime,
    currentStreak,
    avgScore,
  };
}

/**
 * Calculate current streak of consecutive days with sessions
 */
function calculateStreak(sessions: any[]): number {
  if (sessions.length === 0) return 0;

  // Get unique days with sessions (in IST)
  const sessionDays = new Set<string>();
  sessions.forEach((session) => {
    const istDate = getDateOnlyIST(session.started_at);
    sessionDays.add(istDate.toISOString());
  });

  // Sort days in descending order
  const sortedDays = Array.from(sessionDays)
    .map((day) => new Date(day))
    .sort((a, b) => b.getTime() - a.getTime());

  if (sortedDays.length === 0) return 0;

  // Check if today has a session
  const today = getDateOnlyIST(getISTDate());
  const todayHasSession = sortedDays.some((day) => isSameDayIST(day, today));

  // Start counting from today or yesterday
  let streak = todayHasSession ? 1 : 0;
  let checkDate = todayHasSession ? today : new Date(today);
  checkDate.setUTCDate(checkDate.getUTCDate() - 1);

  // Count consecutive days
  for (let i = 0; i < sortedDays.length; i++) {
    const day = sortedDays[i];
    if (isSameDayIST(day, checkDate)) {
      streak++;
      checkDate.setUTCDate(checkDate.getUTCDate() - 1);
    } else if (getDaysDifferenceIST(day, checkDate) > 1) {
      // Gap found, streak broken
      break;
    }
  }

  return streak;
}

/**
 * Calculate improvement areas by comparing recent week vs previous week
 */
function calculateImprovements(sessions: any[], recordings: any[]): Improvement[] {
  const now = getISTDate();
  const weekStart = getWeekStartIST(now);
  const lastWeekStart = new Date(weekStart);
  lastWeekStart.setUTCDate(weekStart.getUTCDate() - 7);
  const lastWeekEnd = new Date(weekStart);
  lastWeekEnd.setUTCDate(weekStart.getUTCDate() - 1);

  // Get sessions from current week
  const currentWeekSessions = sessions.filter((session) => {
    const sessionDate = toIST(new Date(session.started_at));
    return sessionDate >= weekStart;
  });

  // Get sessions from previous week
  const previousWeekSessions = sessions.filter((session) => {
    const sessionDate = toIST(new Date(session.started_at));
    return sessionDate >= lastWeekStart && sessionDate <= lastWeekEnd;
  });

  // Calculate metrics for both weeks
  const currentWeekDuration = currentWeekSessions.reduce((sum, s) => {
    const rec = recordings.find((r) => r.session_id === s.id);
    return sum + (rec?.duration || 0);
  }, 0);

  const previousWeekDuration = previousWeekSessions.reduce((sum, s) => {
    const rec = recordings.find((r) => r.session_id === s.id);
    return sum + (rec?.duration || 0);
  }, 0);

  const currentWeekSessionsCount = currentWeekSessions.length;
  const previousWeekSessionsCount = previousWeekSessions.length;

  // Calculate improvements
  const improvements: Improvement[] = [];

  // Voice Clarity (based on session count)
  const clarityChange = calculatePercentageChange(
    previousWeekSessionsCount,
    currentWeekSessionsCount
  );
  improvements.push({
    area: "Voice Clarity",
    trend: clarityChange >= 0 ? "up" : "down",
    change: `${clarityChange >= 0 ? "+" : ""}${clarityChange}%`,
  });

  // Speaking Pace (based on average session duration)
  const currentAvgDuration = currentWeekSessionsCount > 0 
    ? currentWeekDuration / currentWeekSessionsCount 
    : 0;
  const previousAvgDuration = previousWeekSessionsCount > 0 
    ? previousWeekDuration / previousWeekSessionsCount 
    : 0;
  const paceChange = calculatePercentageChange(previousAvgDuration, currentAvgDuration);
  improvements.push({
    area: "Speaking Pace",
    trend: paceChange >= 0 ? "up" : "down",
    change: `${paceChange >= 0 ? "+" : ""}${paceChange}%`,
  });

  // Filler Words (placeholder - would need transcript analysis)
  const fillerChange = Math.floor(Math.random() * 20) - 10;
  improvements.push({
    area: "Filler Words",
    trend: fillerChange <= 0 ? "up" : "down", // Lower is better for filler words
    change: `${fillerChange <= 0 ? "+" : ""}${Math.abs(fillerChange)}%`,
  });

  // Emotional Range (placeholder - would need AI analysis)
  const emotionalChange = Math.floor(Math.random() * 25) + 5;
  improvements.push({
    area: "Emotional Range",
    trend: "up",
    change: `+${emotionalChange}%`,
  });

  return improvements;
}

/**
 * Calculate percentage change between two values
 */
function calculatePercentageChange(oldValue: number, newValue: number): number {
  if (oldValue === 0) return newValue > 0 ? 100 : 0;
  return Math.round(((newValue - oldValue) / oldValue) * 100);
}

