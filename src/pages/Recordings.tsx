import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { FileText, Trash2, Search, Loader2 } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { useAuth } from "@/hooks/useAuth";
import { toast } from "sonner";
import { AudioPlayer } from "@/components/AudioPlayer";

interface Session {
  id: string;
  category_name: string;
  started_at: string;
  ended_at: string | null;
  notes: string | null;
  ai_summary: string | null;
  message_count?: number;
  recording_url?: string | null;
  recording_duration?: number | null;
}

const Recordings = () => {
  const { user } = useAuth();
  const [sessions, setSessions] = useState<Session[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);
  const [expandedSessionId, setExpandedSessionId] = useState<string | null>(null);
  const [sessionMessages, setSessionMessages] = useState<Record<string, any[]>>({});

  // Fetch sessions from Supabase
  useEffect(() => {
    if (!user?.id) return;

    const fetchSessions = async () => {
      try {
        setLoading(true);
        const { data: sessionsData, error } = await supabase
          .from("sessions")
          .select("id, started_at, ended_at, notes, ai_summary, category_id, user_audio_url")
          .eq("user_id", user.id)
          .order("started_at", { ascending: false });

        if (error) throw error;

        // Fetch category names for all sessions
        const categoryIds = [...new Set((sessionsData || []).map((s: any) => s.category_id))];
        const { data: categoriesData } = await supabase
          .from("categories")
          .select("id, name")
          .in("id", categoryIds);

        const categoryMap = new Map(
          (categoriesData || []).map((cat: any) => [cat.id, cat.name])
        );

        // Transform data to include category name
        const sessionsWithCategories: Session[] = (sessionsData || []).map((session: any) => ({
          id: session.id,
          category_name: categoryMap.get(session.category_id) || "Unknown",
          started_at: session.started_at,
          ended_at: session.ended_at,
          notes: session.notes,
          ai_summary: session.ai_summary,
          user_audio_url: session.user_audio_url || null,
        }));

        // Fetch message counts and recordings for each session
        const sessionsWithData = await Promise.all(
          sessionsWithCategories.map(async (session) => {
            // Fetch message count
            const { count } = await supabase
              .from("messages")
              .select("*", { count: "exact", head: true })
              .eq("session_id", session.id);
            
            // Fetch recording (most recent one for this session)
            const { data: recording } = await supabase
              .from("recordings")
              .select("audio_url, duration")
              .eq("session_id", session.id)
              .order("created_at", { ascending: false })
              .limit(1)
              .maybeSingle();
            
            // Use combined session audio from recordings table, or fallback to user audio from sessions table
            const recordingUrl = recording?.audio_url || session.user_audio_url || null;
            const recordingDuration = recording?.duration || null;
            
            return {
              ...session,
              message_count: count || 0,
              recording_url: recordingUrl,
              recording_duration: recordingDuration,
            };
          })
        );

        setSessions(sessionsWithData);
      } catch (error) {
        console.error("Error fetching sessions:", error);
        toast.error("Failed to load recordings");
      } finally {
        setLoading(false);
      }
    };

    fetchSessions();
  }, [user?.id]);

  // Fetch messages for a session
  const fetchSessionMessages = async (sessionId: string) => {
    if (sessionMessages[sessionId]) return; // Already loaded

    try {
      const { data, error } = await supabase
        .from("messages")
        .select("*")
        .eq("session_id", sessionId)
        .order("created_at", { ascending: true });

      if (error) throw error;
      setSessionMessages((prev) => ({ ...prev, [sessionId]: data || [] }));
    } catch (error) {
      console.error("Error fetching messages:", error);
      toast.error("Failed to load transcript");
    }
  };

  // Format duration
  const formatDuration = (startedAt: string, endedAt: string | null) => {
    if (!endedAt) return "In progress";
    const start = new Date(startedAt);
    const end = new Date(endedAt);
    const diffMs = end.getTime() - start.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffSecs = Math.floor((diffMs % 60000) / 1000);
    return `${diffMins}:${diffSecs.toString().padStart(2, "0")}`;
  };

  // Format date
  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);

    if (diffMins < 1) return "Just now";
    if (diffMins < 60) return `${diffMins}m ago`;
    if (diffHours < 24) return `${diffHours}h ago`;
    if (diffDays === 1) return "Yesterday";
    if (diffDays < 7) return `${diffDays}d ago`;
    return date.toLocaleDateString();
  };

  // Delete session and all related data
  const handleDelete = async (sessionId: string) => {
    if (!confirm("Are you sure you want to delete this session? This will also delete all messages and recordings.")) return;

    try {
      console.log("🗑️ Attempting to delete session:", sessionId, "for user:", user?.id);
      
      // First, verify the session exists and belongs to the user
      const { data: existingSession, error: checkError } = await supabase
        .from("sessions")
        .select("id, user_id")
        .eq("id", sessionId)
        .eq("user_id", user?.id)
        .single();

      if (checkError || !existingSession) {
        console.error("❌ Session not found or doesn't belong to user:", checkError);
        toast.error("Session not found or you don't have permission to delete it.");
        return;
      }

      console.log("✅ Session verified, proceeding with deletion...");

      // Delete related records first (messages and recordings)
      // Delete messages
      const { error: messagesError, count: messagesCount } = await supabase
        .from("messages")
        .delete()
        .eq("session_id", sessionId)
        .select("*", { count: "exact", head: true });
      
      if (messagesError) {
        console.warn("⚠️ Warning deleting messages:", messagesError);
      } else {
        console.log(`✅ Deleted ${messagesCount || 0} messages`);
      }

      // Delete recordings
      const { error: recordingsError, count: recordingsCount } = await supabase
        .from("recordings")
        .delete()
        .eq("session_id", sessionId)
        .select("*", { count: "exact", head: true });
      
      if (recordingsError) {
        console.warn("⚠️ Warning deleting recordings:", recordingsError);
      } else {
        console.log(`✅ Deleted ${recordingsCount || 0} recordings`);
      }

      // Delete the session itself - CRITICAL: Use .select() to verify deletion
      const { data: deletedSessions, error: sessionError } = await supabase
        .from("sessions")
        .delete()
        .eq("id", sessionId)
        .eq("user_id", user?.id)
        .select(); // This returns the deleted rows

      if (sessionError) {
        console.error("❌ Error deleting session:", sessionError);
        throw sessionError;
      }

      // Verify that a session was actually deleted
      if (!deletedSessions || deletedSessions.length === 0) {
        console.error("❌ No session was deleted!");
        console.error("Session ID:", sessionId);
        console.error("User ID:", user?.id);
        console.error("This could be due to:");
        console.error("1. RLS policy blocking DELETE operation");
        console.error("2. Session doesn't exist");
        console.error("3. user_id doesn't match");
        
        toast.error("Failed to delete session. Check console for details. Session may be protected by security policies.");
        return; // Don't update state if nothing was deleted
      }

      console.log("✅ Successfully deleted session:", deletedSessions[0].id);
      console.log("✅ Deleted session details:", {
        id: deletedSessions[0].id,
        started_at: deletedSessions[0].started_at,
        ended_at: deletedSessions[0].ended_at
      });

      // Deletion is already confirmed by deletedSessions.length > 0
      // No need for additional verification query (which causes 406 error)
      console.log("✅ Deletion confirmed - session removed from database");

      // Update local state only after verifying deletion
      setSessions((prev) => prev.filter((s) => s.id !== sessionId));
      
      // Also remove from sessionMessages if expanded
      setSessionMessages((prev) => {
        const updated = { ...prev };
        delete updated[sessionId];
        return updated;
      });
      
      // Close if this session was expanded
      if (expandedSessionId === sessionId) {
        setExpandedSessionId(null);
      }

      toast.success("Session deleted successfully and confirmed");
    } catch (error: any) {
      console.error("❌ Error deleting session:", error);
      const errorMessage = error?.message || error?.code || "Unknown error";
      toast.error(`Failed to delete session: ${errorMessage}`);
    }
  };

  // Filter sessions
  const filteredSessions = sessions.filter((session) => {
    const matchesSearch =
      searchQuery === "" ||
      session.category_name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      session.notes?.toLowerCase().includes(searchQuery.toLowerCase()) ||
      session.ai_summary?.toLowerCase().includes(searchQuery.toLowerCase());

    const matchesCategory = !selectedCategory || session.category_name === selectedCategory;

    return matchesSearch && matchesCategory;
  });

  // Get unique categories from sessions
  const availableCategories = Array.from(
    new Set(sessions.map((s) => s.category_name))
  ).filter(Boolean);


  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-6xl mx-auto space-y-6">
        <div className="space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Recordings & History</h1>
          <p className="text-muted-foreground">Review and manage your practice sessions</p>
        </div>

        {/* Search Bar */}
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground" />
          <Input
            placeholder="Search recordings..."
            className="pl-10"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
          />
        </div>

        {/* Filter Buttons */}
        <div className="flex flex-wrap gap-2">
          <Button
            variant={selectedCategory === null ? "default" : "outline"}
            size="sm"
            onClick={() => setSelectedCategory(null)}
          >
            All
          </Button>
          {availableCategories.map((catName) => (
            <Button
              key={catName}
              variant={selectedCategory === catName ? "default" : "outline"}
              size="sm"
              onClick={() => setSelectedCategory(catName)}
            >
              {catName}
            </Button>
          ))}
        </div>

        {/* Loading State */}
        {loading && (
          <div className="flex items-center justify-center py-12">
            <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
          </div>
        )}

        {/* Empty State */}
        {!loading && filteredSessions.length === 0 && (
          <Card>
            <CardContent className="p-12 text-center">
              <p className="text-muted-foreground">
                {sessions.length === 0
                  ? "No recordings yet. Start a practice session to see your history here."
                  : "No recordings match your search criteria."}
              </p>
            </CardContent>
          </Card>
        )}

        {/* Recordings List */}
        {!loading && (
          <div className="space-y-4">
            {filteredSessions.map((session) => {
              const messages = sessionMessages[session.id] || [];
              const isExpanded = expandedSessionId === session.id;

              return (
                <Card key={session.id} className="hover:shadow-lg transition-shadow">
                  <CardContent className="p-6">
                    <div className="flex items-center justify-between gap-4">
                      <div className="flex-1 space-y-2">
                        <div className="flex items-center gap-3">
                          <h3 className="text-lg font-semibold">{session.category_name}</h3>
                          <Badge variant="secondary">{session.category_name}</Badge>
                          {!session.ended_at && (
                            <Badge variant="outline" className="bg-green-500/10 text-green-600">
                              Active
                            </Badge>
                          )}
                        </div>
                        <div className="flex items-center gap-4 text-sm text-muted-foreground">
                          <span>{formatDate(session.started_at)}</span>
                          <span>•</span>
                          <span>{formatDuration(session.started_at, session.ended_at)}</span>
                          {session.recording_duration && (
                            <>
                              <span>•</span>
                              <span>{Math.floor(session.recording_duration / 60)}:{(session.recording_duration % 60).toString().padStart(2, '0')} audio</span>
                            </>
                          )}
                          {session.message_count !== undefined && (
                            <>
                              <span>•</span>
                              <span>{session.message_count} messages</span>
                            </>
                          )}
                        </div>
                        {session.ai_summary && (
                          <p className="text-sm text-muted-foreground line-clamp-2">
                            {session.ai_summary}
                          </p>
                        )}
                      </div>

                      <div className="flex items-center gap-4">
                        <div className="flex gap-2">
                          <Button
                            variant="outline"
                            size="icon"
                            onClick={() => {
                              if (isExpanded) {
                                setExpandedSessionId(null);
                              } else {
                                setExpandedSessionId(session.id);
                                fetchSessionMessages(session.id);
                              }
                            }}
                            title="View transcript"
                          >
                            <FileText className="w-4 h-4" />
                          </Button>
                          <Button
                            variant="outline"
                            size="icon"
                            className="text-destructive hover:text-destructive"
                            onClick={() => handleDelete(session.id)}
                            title="Delete session"
                          >
                            <Trash2 className="w-4 h-4" />
                          </Button>
                        </div>
                      </div>
                    </div>

                    {/* Audio Player */}
                    {session.recording_url && (
                      <div className="mt-4 pt-4 border-t">
                        <h4 className="font-semibold mb-3">Session Recording</h4>
                        <AudioPlayer
                          audioUrl={session.recording_url}
                          duration={session.recording_duration || undefined}
                          compact={false}
                        />
                        {session.recording_url.endsWith('.mp3') && (
                          <p className="text-xs text-muted-foreground mt-2">
                            ⚠️ This is an older recording format. If playback fails, try a newer session.
                          </p>
                        )}
                      </div>
                    )}

                    {/* Expanded Transcript */}
                    {isExpanded && (
                      <div className="mt-4 pt-4 border-t">
                        <h4 className="font-semibold mb-3">Conversation Transcript</h4>
                        {messages.length === 0 ? (
                          <p className="text-sm text-muted-foreground">Loading transcript...</p>
                        ) : (
                          <div className="space-y-2 max-h-64 overflow-y-auto">
                            {messages.map((msg) => (
                              <div
                                key={msg.id}
                                className={`p-3 rounded ${
                                  msg.sender === "user"
                                    ? "bg-primary/10 ml-4"
                                    : "bg-muted mr-4"
                                }`}
                              >
                                <div className="flex items-start justify-between gap-2">
                                  <div className="flex-1">
                                    <div className="text-xs font-semibold mb-1">
                                      {msg.sender === "user" ? "You" : "AI Coach"}
                                    </div>
                                    <div className="text-sm">{msg.text}</div>
                                  </div>
                                  {msg.audio_url && (
                                    <AudioPlayer
                                      audioUrl={msg.audio_url}
                                      compact={true}
                                      className="shrink-0"
                                    />
                                  )}
                                </div>
                              </div>
                            ))}
                          </div>
                        )}
                      </div>
                    )}
                  </CardContent>
                </Card>
              );
            })}
          </div>
        )}
      </div>
    </div>
  );
};

export default Recordings;
