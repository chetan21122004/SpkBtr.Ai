import type { Category } from "@/hooks/useCategories";
import type * as LucideIcons from "lucide-react";

export interface MockUser {
  id: string;
  name: string;
  email: string;
  password: string;
  created_at: string;
}

export interface MockSession {
  id: string;
  user_id: string;
  category_id: string;
  started_at: string;
  ended_at: string | null;
  notes: string | null;
  ai_summary: string | null;
  tone_score?: number | null;
  confidence_score?: number | null;
  fluency_score?: number | null;
  user_audio_url?: string | null;
}

export interface MockMessage {
  id: string;
  session_id: string;
  sender: "user" | "ai";
  text: string;
  audio_url?: string | null;
  created_at: string;
}

export interface MockRecording {
  id: string;
  user_id: string;
  session_id: string;
  audio_url: string;
  duration: number;
  created_at: string;
}

type SeedCategory = Omit<Category, "icon"> & { icon?: LucideIcons.LucideIcon };

export const seedCategories: SeedCategory[] = [
  {
    id: "cat-1",
    name: "Daily Conversations",
    description: "Practice natural, everyday interactions",
    base_context: "Coach the user for clear, confident daily speech.",
    route_path: "/daily-conversations",
    icon_name: "MessageCircle",
    gradient: "from-cyan-500 to-blue-500",
    display_order: 1,
    is_active: true,
  },
  {
    id: "cat-2",
    name: "Interview Practice",
    description: "Answer questions with structure and confidence",
    base_context: "Coach concise, impact-driven interview responses.",
    route_path: "/interview-practice",
    icon_name: "Briefcase",
    gradient: "from-violet-500 to-purple-500",
    display_order: 2,
    is_active: true,
  },
  {
    id: "cat-3",
    name: "Public Speaking",
    description: "Improve pacing, confidence, and stage presence",
    base_context: "Coach projection, pauses, and storytelling.",
    route_path: "/public-speaking",
    icon_name: "Presentation",
    gradient: "from-amber-500 to-orange-500",
    display_order: 3,
    is_active: true,
  },
];

const now = Date.now();

export const seedUsers: MockUser[] = [
  {
    id: "user-1",
    name: "Demo User",
    email: "demo@spkbtr.ai",
    password: "demo123",
    created_at: new Date(now - 1000 * 60 * 60 * 24 * 90).toISOString(),
  },
];

export const seedSessions: MockSession[] = [
  {
    id: "sess-1",
    user_id: "user-1",
    category_id: "cat-1",
    started_at: new Date(now - 1000 * 60 * 60 * 26).toISOString(),
    ended_at: new Date(now - 1000 * 60 * 60 * 25.7).toISOString(),
    notes: "Focus on reducing filler words.",
    ai_summary: "Good energy. Slow down slightly and close sentences with stronger endings.",
    tone_score: 82,
    confidence_score: 79,
    fluency_score: 85,
    user_audio_url: null,
  },
  {
    id: "sess-2",
    user_id: "user-1",
    category_id: "cat-2",
    started_at: new Date(now - 1000 * 60 * 60 * 5).toISOString(),
    ended_at: new Date(now - 1000 * 60 * 60 * 4.8).toISOString(),
    notes: "STAR format practice.",
    ai_summary: "Great examples. Add clearer outcomes and metrics.",
    tone_score: 86,
    confidence_score: 84,
    fluency_score: 81,
    user_audio_url: null,
  },
];

export const seedMessages: MockMessage[] = [
  {
    id: "msg-1",
    session_id: "sess-1",
    sender: "user",
    text: "I usually freeze when introducing myself in a group.",
    created_at: new Date(now - 1000 * 60 * 60 * 26 + 1000 * 60).toISOString(),
  },
  {
    id: "msg-2",
    session_id: "sess-1",
    sender: "ai",
    text: "Try a 10-second structure: name, role, one current focus.",
    created_at: new Date(now - 1000 * 60 * 60 * 26 + 1000 * 120).toISOString(),
  },
  {
    id: "msg-3",
    session_id: "sess-2",
    sender: "user",
    text: "I improved onboarding time by 30% through automation.",
    created_at: new Date(now - 1000 * 60 * 60 * 5 + 1000 * 60).toISOString(),
  },
  {
    id: "msg-4",
    session_id: "sess-2",
    sender: "ai",
    text: "Strong impact statement. Add team size and timeline for context.",
    created_at: new Date(now - 1000 * 60 * 60 * 5 + 1000 * 120).toISOString(),
  },
];

export const seedRecordings: MockRecording[] = [
  {
    id: "rec-1",
    user_id: "user-1",
    session_id: "sess-1",
    audio_url: "https://actions.google.com/sounds/v1/cartoon/clang_and_wobble.ogg",
    duration: 182,
    created_at: new Date(now - 1000 * 60 * 60 * 25.7).toISOString(),
  },
  {
    id: "rec-2",
    user_id: "user-1",
    session_id: "sess-2",
    audio_url: "https://actions.google.com/sounds/v1/cartoon/concussive_drum_hit.ogg",
    duration: 141,
    created_at: new Date(now - 1000 * 60 * 60 * 4.8).toISOString(),
  },
];
