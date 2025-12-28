import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Play, Volume2 } from "lucide-react";
import { Progress } from "@/components/ui/progress";

interface FeedbackCardProps {
  tone: string;
  energy: number;
  tip: string;
  onPlayAudio: () => void;
}

const FeedbackCard = ({ tone, energy, tip, onPlayAudio }: FeedbackCardProps) => {
  return (
    <Card className="w-full max-w-2xl animate-fade-in bg-card/80 backdrop-blur-sm border-primary/20 shadow-[var(--shadow-soft)]">
      <CardHeader>
        <CardTitle className="flex items-center gap-2 text-foreground">
          <Volume2 className="w-5 h-5 text-primary" />
          Voice Analysis
        </CardTitle>
      </CardHeader>
      <CardContent className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div className="space-y-2">
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Tone</span>
              <span className="font-medium text-foreground">{tone}</span>
            </div>
          </div>
          <div className="space-y-2">
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Energy Level</span>
              <span className="font-medium text-foreground">{energy}/10</span>
            </div>
            <Progress value={energy * 10} className="h-2" />
          </div>
        </div>
        
        <div className="space-y-2 p-4 bg-muted/50 rounded-lg border border-border">
          <p className="text-sm font-medium text-foreground">💡 Coaching Tip</p>
          <p className="text-sm text-muted-foreground">{tip}</p>
        </div>

        <Button 
          onClick={onPlayAudio} 
          variant="outline" 
          className="w-full"
        >
          <Play className="w-4 h-4 mr-2" />
          Play AI Feedback
        </Button>
      </CardContent>
    </Card>
  );
};

export default FeedbackCard;
