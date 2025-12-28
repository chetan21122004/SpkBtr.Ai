import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import { Award, TrendingUp, Zap, Loader2 } from "lucide-react";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useAuth } from "@/hooks/useAuth";
import AISpeakingAnimation from "@/components/AISpeakingAnimation";
import { useState } from "react";

const PublicSpeaking = () => {
  const { user } = useAuth();
  const [isLoading, setIsLoading] = useState(false);
  const { audioRef, isListening, startSession, stopSession, isAISpeaking } = useVoiceConversation({
    categoryName: "Public Speaking",
    userId: user?.id,
  });

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-4xl mx-auto space-y-8">
        <div className="text-center space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Public Speaking Practice</h1>
          <p className="text-muted-foreground">Record your speech and receive AI-powered feedback</p>
        </div>

        {/* AI Speaking Animation */}
        <AISpeakingAnimation 
          isListening={isListening}
          audioRef={audioRef}
          categoryName="Public Speaking"
          size="large"
          onLoadingChange={setIsLoading}
        />

        <div className="space-y-8 animate-fade-in">
          <Button 
            size="xl" 
            variant="hero"
            onClick={isListening ? stopSession : startSession}
            disabled={isLoading && !isListening}
          >
            {isLoading && !isListening ? (
              <>
                <Loader2 className="w-5 h-5 mr-2 animate-spin" />
                Connecting...
              </>
            ) : (
              <>
            {isListening ? "Stop Session" : "Start Coaching Session"}
              </>
            )}
          </Button>

          {isListening && (
            <div className="text-center space-y-4">
              <WaveformVisualizer isActive={isListening} status="listening" />
            </div>
          )}

          <audio ref={audioRef} className="hidden" />
        </div>
      </div>
    </div>
  );
};

export default PublicSpeaking;
