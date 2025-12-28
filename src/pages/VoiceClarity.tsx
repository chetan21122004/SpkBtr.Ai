import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import { RefreshCw, Play, Mic, Loader2 } from "lucide-react";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useAuth } from "@/hooks/useAuth";
import AISpeakingAnimation from "@/components/AISpeakingAnimation";

const VoiceClarity = () => {
  const { user } = useAuth();
  const [isLoading, setIsLoading] = useState(false);
  const { audioRef, isListening, startSession, stopSession, isAISpeaking } = useVoiceConversation({
    categoryName: "Voice Clarity",
    userId: user?.id,
  });
  const [score, setScore] = useState<number | null>(null);

  const words = [
    { word: "Pronunciation", difficulty: "Hard" },
    { word: "Communication", difficulty: "Medium" },
    { word: "Articulation", difficulty: "Hard" },
    { word: "Expression", difficulty: "Easy" },
  ];

  const [currentWord, setCurrentWord] = useState(words[0]);

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-4xl mx-auto space-y-6">
        <div className="text-center space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Voice Clarity & Pronunciation</h1>
          <p className="text-muted-foreground">Perfect your articulation one word at a time</p>
        </div>

        {/* AI Speaking Animation */}
        <AISpeakingAnimation 
          isListening={isListening}
          audioRef={audioRef}
          categoryName="Voice Clarity"
          size="large"
          onLoadingChange={setIsLoading}
        />

        <Card className="bg-gradient-to-br from-primary/10 to-accent/10">
          <CardContent className="p-12 text-center space-y-6">
            <div className="space-y-2">
              <p className="text-sm text-muted-foreground uppercase tracking-wide">Practice Word</p>
              <h2 className="text-6xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
                {currentWord.word}
              </h2>
              <Button variant="ghost" size="sm">
                <Play className="w-4 h-4 mr-2" />
                Hear pronunciation
              </Button>
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
            <Mic className="w-5 h-5 mr-2" />
                {isListening ? "Stop Recording" : "Start Coaching Session"}
              </>
            )}
          </Button>
        </div>

        <WaveformVisualizer 
          isActive={isListening}
          status={isListening ? "listening" : "idle"}
        />
        <audio ref={audioRef} className="hidden" />

        {score !== null && (
          <Card>
            <CardContent className="p-6 space-y-6">
              <div className="text-center space-y-2">
                <h3 className="text-lg font-semibold">Your Score</h3>
                <div className="text-5xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
                  {score}%
                </div>
              </div>

              <div className="space-y-4">
                <div className="text-center text-2xl tracking-wider">
                  {currentWord.word.split('').map((char, index) => (
                    <span 
                      key={index}
                      className={Math.random() > 0.2 ? "text-green-500" : "text-red-500"}
                    >
                      {char}
                    </span>
                  ))}
                </div>
                
                <Progress value={score} />
              </div>

              <div className="flex gap-3">
                <Button variant="outline" className="flex-1">
                  <Play className="w-4 h-4 mr-2" />
                  Compare Recordings
                </Button>
                <Button 
                  className="flex-1"
                  onClick={() => {
                    const nextIndex = (words.indexOf(currentWord) + 1) % words.length;
                    setCurrentWord(words[nextIndex]);
                    setScore(null);
                  }}
                >
                  <RefreshCw className="w-4 h-4 mr-2" />
                  Next Word
                </Button>
              </div>
            </CardContent>
          </Card>
        )}

        <Card>
          <CardContent className="p-6">
            <h3 className="font-semibold mb-4">Upcoming Words</h3>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
              {words.map((word, index) => (
                <Button
                  key={index}
                  variant="outline"
                  className="h-auto p-4 flex flex-col items-start"
                  onClick={() => {
                    setCurrentWord(word);
                    setScore(null);
                  }}
                >
                  <span className="font-semibold">{word.word}</span>
                  <span className="text-xs text-muted-foreground">{word.difficulty}</span>
                </Button>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default VoiceClarity;
