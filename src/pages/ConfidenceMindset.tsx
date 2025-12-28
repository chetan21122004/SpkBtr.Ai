import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Mic, Loader2 } from "lucide-react";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useAuth } from "@/hooks/useAuth";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import AISpeakingAnimation from "@/components/AISpeakingAnimation";

const ConfidenceMindset = () => {
  const { user } = useAuth();
  const { audioRef, isListening, startSession, stopSession, isAISpeaking } = useVoiceConversation({
    categoryName: "Confidence & Mindset",
    userId: user?.id,
  });
  const [progress, setProgress] = useState(65);
  const [isLoading, setIsLoading] = useState(false);

  const affirmations = [
    "I speak with clarity and confidence",
    "My voice is powerful and authentic",
    "I communicate my ideas effectively",
    "I am calm and composed in all situations",
  ];

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-4xl mx-auto space-y-6">
        <div className="text-center space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Confidence & Mindset</h1>
          <p className="text-muted-foreground">Build mental strength and speaking confidence</p>
        </div>

        {/* Ai speaking indicator Animation */}
        <AISpeakingAnimation 
          isListening={isListening}
          audioRef={audioRef}
          categoryName="Confidence & Mindset"
          size="large"
          onLoadingChange={setIsLoading}
        />

        <Card>
          <CardContent className="p-8 space-y-6">
            <div className="text-center space-y-4">
              <h3 className="text-2xl font-semibold">Today's Affirmation</h3>
              <p className="text-3xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
                {affirmations[0]}
              </p>
            </div>

            <div className="flex justify-center">
              <Button
                size="lg"
                variant={isListening ? "destructive" : "default"}
                onClick={isListening ? stopSession : startSession}
                className="rounded-full px-12"
                disabled={isLoading && !isListening}
              >
                {isLoading && !isListening ? (
                  <>
                    <Loader2 className="w-5 h-5 mr-2 animate-spin" />
                    Connecting...
                  </>
                ) : (
                  <>
                <Mic className="w-5 h-5 mr-2" />
                    {isListening ? "Stop Session" : "Start Coaching Session"}
                  </>
                )}
              </Button>
            </div>

            {isListening && (
              <div className="space-y-4 animate-fade-in">
                <WaveformVisualizer 
                  isActive={isListening}
                  status="listening"
                />

                <Card className="bg-primary/5 border-primary/20">
                  <CardContent className="p-4 text-center">
                    <p className="text-lg font-medium text-primary">
                      Your tone is steady and calm ✓
                    </p>
                  </CardContent>
                </Card>
              </div>
            )}
            <audio ref={audioRef} className="hidden" />
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6 space-y-6">
            <h3 className="text-lg font-semibold text-center">Confidence Growth</h3>
            
            <div className="relative pt-8">
              <div className="absolute top-0 left-1/2 -translate-x-1/2">
                <div className="relative w-32 h-32">
                  <svg className="w-full h-full" viewBox="0 0 100 100">
                    <circle
                      className="text-muted stroke-current"
                      strokeWidth="10"
                      fill="transparent"
                      r="40"
                      cx="50"
                      cy="50"
                    />
                    <circle
                      className="text-primary stroke-current"
                      strokeWidth="10"
                      strokeLinecap="round"
                      fill="transparent"
                      r="40"
                      cx="50"
                      cy="50"
                      style={{
                        strokeDasharray: `${2 * Math.PI * 40}`,
                        strokeDashoffset: `${2 * Math.PI * 40 * (1 - progress / 100)}`,
                        transform: 'rotate(-90deg)',
                        transformOrigin: '50% 50%',
                      }}
                    />
                  </svg>
                  <div className="absolute inset-0 flex items-center justify-center">
                    <span className="text-3xl font-bold">{progress}%</span>
                  </div>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-3 gap-4 text-center pt-24">
              <div className="space-y-1">
                <p className="text-2xl font-bold text-primary">12</p>
                <p className="text-sm text-muted-foreground">Sessions</p>
              </div>
              <div className="space-y-1">
                <p className="text-2xl font-bold text-primary">8</p>
                <p className="text-sm text-muted-foreground">Day Streak</p>
              </div>
              <div className="space-y-1">
                <p className="text-2xl font-bold text-primary">+15%</p>
                <p className="text-sm text-muted-foreground">This Week</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6 space-y-3">
            <h3 className="font-semibold">More Affirmations</h3>
            <div className="space-y-2">
              {affirmations.slice(1).map((affirmation, index) => (
                <Button
                  key={index}
                  variant="outline"
                  className="w-full justify-start h-auto p-4 text-left"
                >
                  {affirmation}
                </Button>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default ConfidenceMindset;
