import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import { ChevronRight, Volume2, Loader2 } from "lucide-react";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useAuth } from "@/hooks/useAuth";
import AISpeakingAnimation from "@/components/AISpeakingAnimation";

const InterviewPractice = () => {
  const { user } = useAuth();
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const { audioRef, isListening, startSession, stopSession, isAISpeaking } = useVoiceConversation({
    categoryName: "Interview Practice",
    userId: user?.id,
  });

  const questions = [
    "Tell me about yourself and your background.",
    "What are your greatest strengths?",
    "Describe a challenging situation you faced and how you handled it.",
    "Why do you want to work here?",
  ];

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-6xl mx-auto space-y-6">
        <div className="text-center space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Interview Practice</h1>
          <p className="text-muted-foreground">Practice with our AI interviewer</p>
        </div>

        {/* AI Speaking Animation */}
        <AISpeakingAnimation 
          isListening={isListening}
          audioRef={audioRef}
          categoryName="Interview Practice"
          size="large"
          onLoadingChange={setIsLoading}
        />

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Interviewer Side */}
          <Card>
            <CardContent className="p-8 space-y-6">
              <div className="flex flex-col items-center space-y-4">
                <Avatar className="w-24 h-24 border-4 border-primary">
                  <AvatarFallback className="bg-gradient-to-br from-primary to-accent text-white text-2xl">
                    AI
                  </AvatarFallback>
                </Avatar>
                <h3 className="text-xl font-semibold">AI Interviewer</h3>
              </div>

              <Card className="bg-muted/50">
                <CardContent className="p-6 space-y-4">
                  <div className="flex items-start gap-3">
                    <Volume2 className="w-5 h-5 text-primary mt-1" />
                    <p className="text-lg">{questions[currentQuestion]}</p>
                  </div>
                  <Button variant="outline" size="sm" className="w-full">
                    <Volume2 className="w-4 h-4 mr-2" />
                    Repeat Question
                  </Button>
                </CardContent>
              </Card>

              <div className="text-center text-sm text-muted-foreground">
                Question {currentQuestion + 1} of {questions.length}
              </div>
            </CardContent>
          </Card>

          {/* User Response Side */}
          <Card>
            <CardContent className="p-8 space-y-6">
              <div className="text-center">
                <h3 className="text-xl font-semibold mb-4">Your Response</h3>
              <Button 
                size="lg"
                onClick={isListening ? stopSession : startSession}
                variant={isListening ? "destructive" : "default"}
                disabled={isLoading && !isListening}
              >
                {isLoading && !isListening ? (
                  <>
                    <Loader2 className="w-5 h-5 mr-2 animate-spin" />
                    Connecting...
                  </>
                ) : (
                  <>
                {isListening ? "Stop Recording" : "Start Recording"}
                  </>
                )}
              </Button>
            </div>

            <WaveformVisualizer 
              isActive={isListening}
              status={isListening ? "listening" : "idle"}
            />
            <audio ref={audioRef} className="hidden" />

            {isListening && (
                <Card className="bg-primary/5 border-primary/20">
                  <CardContent className="p-4 space-y-3">
                    <h4 className="font-semibold">Live Feedback</h4>
                    <div className="space-y-2 text-sm">
                      <p>✓ Good pace and clarity</p>
                      <p>✓ Confident tone detected</p>
                      <p>⚠ Try to reduce filler words</p>
                    </div>
                  </CardContent>
                </Card>
              )}

              {!isListening && currentQuestion < questions.length - 1 && (
                <Button 
                  className="w-full" 
                  size="lg"
                  onClick={() => setCurrentQuestion(currentQuestion + 1)}
                >
                  Next Question
                  <ChevronRight className="w-5 h-5 ml-2" />
                </Button>
              )}
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default InterviewPractice;
