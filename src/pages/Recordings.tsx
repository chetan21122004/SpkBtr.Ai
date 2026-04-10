import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { FileText, Trash2, Search, Loader2 } from "lucide-react";
import { useAuth } from "@/hooks/useAuth";
import { toast } from "sonner";
import { AudioPlayer } from "@/components/AudioPlayer";
import { mockDb } from "@/mocks/mockDb";
import type { MockMessage, MockSession } from "@/mocks/mockData";

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
  const [sessionMessages, setSessionMessages] = useState<Record<string, MockMessage[]>>({});

  // Fetch sessions from Supabase
  useEffect(() => {
    if (!user?.id) return;

    const fetchSessions = async () => {
      try {
        setLoading(true);
        const [sessionsData, categoriesData] = await Promise.all([
          mockDb.getSessionsByUser(user.id),
          mockDb.getCategories(),
        ]);
        const categoryMap = new Map((categoriesData || []).map((cat) => [cat.id, cat.name]));

        // Transform data to include category name
        const sessionsWithCategories: Session[] = (sessionsData || []).map((session: MockSession) => ({
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
            const [count, recording] = await Promise.all([
              mockDb.getMessageCountBySession(session.id),
              mockDb.getLatestRecordingBySession(session.id),
            ]);
            
            // Use combined session audio from recordings table, or fallback to user audio from sessions table
            const recordingUrl = recording?.audio_url || session.user_audio_url || null;
            const recordingDuration = recording?.duration || null;
            
            return {
              ...session,
              message_count: count,
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
      const data = await mockDb.getMessagesBySession(sessionId);
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
      const deleted = await mockDb.deleteSession(user?.id || "", sessionId);
      if (!deleted) {
        toast.error("Session not found or you don't have permission to delete it.");
        return;
      }

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

      toast.success("Session deleted successfully");
    } catch (error: unknown) {
      console.error("❌ Error deleting session:", error);
      const errorMessage = error instanceof Error ? error.message : "Unknown error";
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
