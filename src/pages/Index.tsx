import { useState } from "react";
import StartButton from "@/components/StartButton";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import FeedbackCard from "@/components/FeedbackCard";
import SessionControls from "@/components/SessionControls";
import { useToast } from "@/hooks/use-toast";

type SessionStatus = "idle" | "listening" | "analyzing";

const Index = () => {
  const [isRecording, setIsRecording] = useState(false);
  const [sessionStatus, setSessionStatus] = useState<SessionStatus>("idle");
  const [showFeedback, setShowFeedback] = useState(false);
  const { toast } = useToast();

  const handleStartStop = () => {
    if (!isRecording) {
      // Start recording
      setIsRecording(true);
      setSessionStatus("listening");
      setShowFeedback(false);
      
      // Simulate recording for 3 seconds
      setTimeout(() => {
        setSessionStatus("analyzing");
        
        // Then show feedback after 2 seconds
        setTimeout(() => {
          setIsRecording(false);
          setSessionStatus("idle");
          setShowFeedback(true);
        }, 2000);
      }, 3000);
    } else {
      // Stop recording early
      setIsRecording(false);
      setSessionStatus("analyzing");
      
      setTimeout(() => {
        setSessionStatus("idle");
        setShowFeedback(true);
      }, 1500);
    }
  };

  const handlePlayAudio = () => {
    toast({
      title: "Playing AI Feedback",
      description: "Audio playback started",
    });
  };

  const handleReplay = () => {
    setShowFeedback(false);
    handleStartStop();
  };

  const handleHistory = () => {
    toast({
      title: "Session History",
      description: "View your past coaching sessions",
    });
  };

  const handleProgress = () => {
    toast({
      title: "Your Progress",
      description: "Track your improvement over time",
    });
  };

  return (
    <div className="relative min-h-screen bg-gradient-to-br from-background via-background to-accent/5 overflow-hidden">
      {/* Decorative gradient orbs */}
      <div className="absolute top-0 left-0 w-96 h-96 bg-primary/10 rounded-full blur-3xl" />
      <div className="absolute bottom-0 right-0 w-96 h-96 bg-accent/10 rounded-full blur-3xl" />
      
      <main className="relative z-10 flex min-h-screen flex-col items-center justify-center p-8 gap-12">
        {!isRecording && !showFeedback && (
          <div className="text-center space-y-4 animate-fade-in">
            <h1 className="text-5xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
              Voice Coach AI
            </h1>
            <p className="text-muted-foreground text-lg max-w-md mx-auto">
              Click to start practicing your voice with AI-powered feedback
            </p>
          </div>
        )}

        <div className="flex flex-col items-center gap-8">
          <StartButton isRecording={isRecording} onClick={handleStartStop} />
          
          <WaveformVisualizer 
            isActive={isRecording} 
            status={sessionStatus}
          />
        </div>

        {showFeedback && (
          <div className="space-y-8 w-full flex flex-col items-center">
            <FeedbackCard
              tone="Calm"
              energy={7.8}
              tip="Try adding a bit more energy to your delivery. Your tone is great, but increasing your enthusiasm will help engage your audience better."
              onPlayAudio={handlePlayAudio}
            />
            
            <SessionControls
              onReplay={handleReplay}
              onHistory={handleHistory}
              onProgress={handleProgress}
            />
          </div>
        )}
      </main>
    </div>
  );
};

export default Index;
