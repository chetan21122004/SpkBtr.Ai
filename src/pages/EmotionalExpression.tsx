import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import { Smile, Frown, Heart, Zap, Loader2 } from "lucide-react";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useAuth } from "@/hooks/useAuth";
import AISpeakingAnimation from "@/components/AISpeakingAnimation";

const EmotionalExpression = () => {
  const { user } = useAuth();
  const [selectedEmotion, setSelectedEmotion] = useState("joy");
  const [isLoading, setIsLoading] = useState(false);
  const { audioRef, isListening, startSession, stopSession, isAISpeaking } = useVoiceConversation({
    categoryName: "Emotional Expression",
    userId: user?.id,
  });
  const [result, setResult] = useState<number | null>(null);

  const emotions = [
    { name: "joy", label: "Joy", icon: Smile, color: "from-yellow-500 to-orange-500", line: "I'm so excited about this opportunity!" },
    { name: "sadness", label: "Sadness", icon: Frown, color: "from-blue-500 to-indigo-500", line: "This is really disappointing news." },
    { name: "confidence", label: "Confidence", icon: Zap, color: "from-purple-500 to-pink-500", line: "I know I can handle this challenge." },
    { name: "empathy", label: "Empathy", icon: Heart, color: "from-pink-500 to-red-500", line: "I understand how difficult this must be for you." },
  ];

  const currentEmotion = emotions.find(e => e.name === selectedEmotion) || emotions[0];
  const Icon = currentEmotion.icon;

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-4xl mx-auto space-y-6">
        <div className="text-center space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Emotional Expression</h1>
          <p className="text-muted-foreground">Practice conveying emotions effectively</p>
        </div>

        {/* AI Speaking Animation */}
        <AISpeakingAnimation 
          isListening={isListening}
          audioRef={audioRef}
          categoryName="Emotional Expression"
          size="large"
          onLoadingChange={setIsLoading}
        />

        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {emotions.map((emotion) => {
            const EmotionIcon = emotion.icon;
            return (
              <Button
                key={emotion.name}
                variant={selectedEmotion === emotion.name ? "default" : "outline"}
                className="h-24 flex flex-col gap-2"
                onClick={() => {
                  setSelectedEmotion(emotion.name);
                  setResult(null);
                }}
              >
                <EmotionIcon className="w-8 h-8" />
                <span>{emotion.label}</span>
              </Button>
            );
          })}
        </div>

        <Card className={`bg-gradient-to-br ${currentEmotion.color} text-white`}>
          <CardContent className="p-12 text-center space-y-6">
            <Icon className="w-20 h-20 mx-auto" />
            <div className="space-y-2">
              <h2 className="text-3xl font-bold">Express: {currentEmotion.label}</h2>
              <p className="text-2xl font-medium opacity-90">
                "{currentEmotion.line}"
              </p>
            </div>
          </CardContent>
        </Card>

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
                {isListening ? "Stop Session" : "Start Coaching Session"}
              </>
            )}
          </Button>
        </div>

        <WaveformVisualizer 
          isActive={isListening}
          status={isListening ? "listening" : "idle"}
        />
        <audio ref={audioRef} className="hidden" />

        {result !== null && (
          <Card>
            <CardContent className="p-6 space-y-6">
              <div className="text-center space-y-4">
                <h3 className="text-lg font-semibold">AI Feedback</h3>
                <p className="text-3xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
                  You sounded {result}% {currentEmotion.label.toLowerCase()}
                </p>
              </div>

              <div className="space-y-4">
                <div className="space-y-2">
                  <div className="flex justify-between text-sm">
                    <span>Emotion Intensity</span>
                    <span className="font-medium">{result}%</span>
                  </div>
                  <Progress value={result} />
                </div>

                <div className="space-y-2">
                  <div className="flex justify-between text-sm">
                    <span>Tone Match</span>
                    <span className="font-medium">{Math.floor(result * 0.9)}%</span>
                  </div>
                  <Progress value={result * 0.9} />
                </div>

                <div className="space-y-2">
                  <div className="flex justify-between text-sm">
                    <span>Authenticity</span>
                    <span className="font-medium">{Math.floor(result * 1.1)}%</span>
                  </div>
                  <Progress value={Math.min(100, result * 1.1)} />
                </div>
              </div>

              <Card className="bg-muted">
                <CardContent className="p-4">
                  <p className="text-sm">
                    <strong>Tip:</strong> {result > 80 
                      ? "Great job! Your emotional expression is authentic and clear." 
                      : "Try to connect more deeply with the emotion. Think about a time you genuinely felt this way."}
                  </p>
                </CardContent>
              </Card>
            </CardContent>
          </Card>
        )}
      </div>
    </div>
  );
};

export default EmotionalExpression;
