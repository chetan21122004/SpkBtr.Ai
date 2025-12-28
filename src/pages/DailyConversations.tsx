import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Mic, Volume2, Send, Loader2 } from "lucide-react";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useAuth } from "@/hooks/useAuth";
import { supabase } from "@/integrations/supabase/client";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import AITypingIndicator from "@/components/AITypingIndicator";
import AISpeakingAnimation from "@/components/AISpeakingAnimation";

interface Message {
  sender: "AI" | "You";
  text: string;
  audio: boolean;
  scores?: { tone: number; fluency: number };
}

const DailyConversations = () => {
  const { user } = useAuth();
  const [messages, setMessages] = useState<Message[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const { audioRef, isListening, startSession, stopSession, sessionId, saveUserMessage, isAISpeaking } = useVoiceConversation({
    categoryName: "Daily Conversations",
    userId: user?.id,
  });

  // Load messages from Supabase
  useEffect(() => {
    const loadMessages = async () => {
      if (!sessionId) return;
      
      try {
        const { data } = await supabase
          .from("messages")
          .select("sender, text, created_at")
          .eq("session_id", sessionId)
          .order("created_at", { ascending: true });

        if (data) {
          const formattedMessages: Message[] = data.map((msg) => ({
            sender: msg.sender === "ai" ? "AI" : "You",
            text: msg.text,
            audio: msg.sender === "ai",
            scores: { tone: 85, fluency: 90 }, // You can load actual scores from progress_stats
          }));
          setMessages(formattedMessages);
        }
      } catch (error) {
        console.error("Error loading messages:", error);
      }
    };

    loadMessages();
  }, [sessionId]);

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-4xl mx-auto space-y-6">
        <div className="text-center space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Daily Conversations</h1>
          <p className="text-muted-foreground">Practice natural, everyday interactions</p>
        </div>

        {/* AI Speaking Animation */}
        <AISpeakingAnimation 
          isListening={isListening}
          audioRef={audioRef}
          categoryName="Daily Conversations"
          size="large"
          onLoadingChange={setIsLoading}
        />

        <Card className="h-[600px] flex flex-col">
          <CardContent className="flex-1 p-6 space-y-4 overflow-y-auto">
            {messages.map((message, index) => (
              <div 
                key={index}
                className={`flex gap-3 ${message.sender === "You" ? "flex-row-reverse" : ""}`}
              >
                <Avatar className="w-10 h-10">
                  <AvatarFallback className={message.sender === "AI" 
                    ? "bg-gradient-to-br from-primary to-accent text-white" 
                    : "bg-muted"
                  }>
                    {message.sender === "AI" ? "AI" : "U"}
                  </AvatarFallback>
                </Avatar>

                <div className={`flex flex-col gap-2 max-w-[70%] ${message.sender === "You" ? "items-end" : ""}`}>
                  <Card className={message.sender === "You" 
                    ? "bg-primary text-primary-foreground" 
                    : "bg-muted"
                  }>
                    <CardContent className="p-4">
                      <p className="text-sm">{message.text}</p>
                      {message.audio && (
                        <Button 
                          variant="ghost" 
                          size="sm" 
                          className="mt-2 h-8"
                        >
                          <Volume2 className="w-4 h-4 mr-2" />
                          Play
                        </Button>
                      )}
                    </CardContent>
                  </Card>

                  <div className="flex gap-2">
                    <Badge variant="secondary" className="text-xs">
                      Tone: {message.scores.tone}%
                    </Badge>
                    <Badge variant="secondary" className="text-xs">
                      Fluency: {message.scores.fluency}%
                    </Badge>
                  </div>
                </div>
              </div>
            ))}
            {isAISpeaking && <AITypingIndicator />}
          </CardContent>

          <div className="border-t p-4">
            <div className="flex gap-3">
              <Button
                variant={isListening ? "destructive" : "default"}
                size="icon"
                className="rounded-full"
                onClick={isListening ? stopSession : startSession}
                disabled={isLoading && !isListening}
              >
                {isLoading && !isListening ? (
                  <Loader2 className="w-5 h-5 animate-spin" />
                ) : (
                <Mic className="w-5 h-5" />
                )}
              </Button>
              <div className="flex-1 flex items-center justify-center">
                {isListening ? (
                  <div className="flex items-center gap-2 text-destructive">
                    <div className="w-3 h-3 bg-destructive rounded-full animate-pulse" />
                    <span className="text-sm font-medium">Recording...</span>
                  </div>
                ) : (
                  <span className="text-sm text-muted-foreground">Click to start conversation</span>
                )}
              </div>
              {isListening && (
                <WaveformVisualizer isActive={isListening} status="listening" />
              )}
            </div>
          </div>
          <audio ref={audioRef} className="hidden" />
        </Card>

        <Card>
          <CardContent className="p-6">
            <h3 className="font-semibold mb-3">Session Summary</h3>
            <div className="grid grid-cols-3 gap-4 text-center">
              <div>
                <p className="text-2xl font-bold text-primary">85%</p>
                <p className="text-sm text-muted-foreground">Avg Tone</p>
              </div>
              <div>
                <p className="text-2xl font-bold text-primary">90%</p>
                <p className="text-sm text-muted-foreground">Avg Fluency</p>
              </div>
              <div>
                <p className="text-2xl font-bold text-primary">12</p>
                <p className="text-sm text-muted-foreground">Exchanges</p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default DailyConversations;
