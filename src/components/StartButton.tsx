import { Mic, Square } from "lucide-react";
import { Button } from "@/components/ui/button";

interface StartButtonProps {
  isRecording: boolean;
  onClick: () => void;
}

const StartButton = ({ isRecording, onClick }: StartButtonProps) => {
  return (
    <div className="relative">
      {isRecording && (
        <div className="absolute inset-0 rounded-full bg-primary/30 animate-ripple" />
      )}
      <Button
        variant="hero"
        size="xl"
        onClick={onClick}
        className={`relative ${isRecording ? "" : "animate-pulse-glow"}`}
      >
        {isRecording ? (
          <>
            <Square className="w-6 h-6 fill-current" />
            Stop Recording
          </>
        ) : (
          <>
            <Mic className="w-6 h-6" />
            Start Coaching Session
          </>
        )}
      </Button>
    </div>
  );
};

export default StartButton;
