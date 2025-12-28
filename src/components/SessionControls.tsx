import { Button } from "@/components/ui/button";
import { RotateCcw, Clock, TrendingUp, Settings, User } from "lucide-react";

interface SessionControlsProps {
  onReplay: () => void;
  onHistory: () => void;
  onProgress: () => void;
}

const SessionControls = ({ onReplay, onHistory, onProgress }: SessionControlsProps) => {
  return (
    <div className="flex flex-wrap items-center justify-center gap-4 animate-fade-in">
      <Button variant="ghost" size="sm" onClick={onReplay}>
        <RotateCcw className="w-4 h-4 mr-2" />
        Replay
      </Button>
      <Button variant="ghost" size="sm" onClick={onHistory}>
        <Clock className="w-4 h-4 mr-2" />
        History
      </Button>
      <Button variant="ghost" size="sm" onClick={onProgress}>
        <TrendingUp className="w-4 h-4 mr-2" />
        Progress
      </Button>
    </div>
  );
};

export const HeaderControls = () => {
  return (
    <div className="absolute top-6 right-6 flex gap-2">
      <Button variant="ghost" size="icon" className="rounded-full">
        <Settings className="w-5 h-5" />
      </Button>
      <Button variant="ghost" size="icon" className="rounded-full">
        <User className="w-5 h-5" />
      </Button>
    </div>
  );
};

export default SessionControls;
