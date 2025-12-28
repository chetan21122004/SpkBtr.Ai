import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Play, TrendingUp, Award, Target, Mic, Sparkles, Clock, BarChart3, Square } from "lucide-react";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useAuth } from "@/hooks/useAuth";
import WaveformVisualizer from "@/components/WaveformVisualizer";

const Dashboard = () => {
  const { user } = useAuth();
  const { audioRef, isListening, isConnected, startSession, stopSession } = useVoiceConversation({
    categoryName: "Public Speaking", // Default category for dashboard
    userId: user?.id,
  });
  const stats = [
    { title: "Tone Score", value: "8.5", max: "10", color: "from-primary to-accent" },
    { title: "Confidence", value: "82", max: "100", color: "from-accent to-primary" },
    { title: "Fluency", value: "75", max: "100", color: "from-primary to-accent" },
  ];

  const recentSessions = [
    { title: "Public Speaking Practice", date: "Today", duration: "12 min", score: 85 },
    { title: "Interview Practice", date: "Yesterday", duration: "8 min", score: 78 },
    { title: "Daily Conversation", date: "2 days ago", duration: "15 min", score: 92 },
  ];

  return (
    <div className="min-h-screen bg-background p-6 space-y-8">
      <div className="max-w-7xl mx-auto space-y-8">
        {/* Hero Start Conversation Section */}
        <div className="relative flex flex-col items-center justify-center py-16 space-y-8 animate-fade-in">
          {/* Floating background elements */}
          <div className="absolute inset-0 -z-10 overflow-hidden">
            <div className="absolute top-1/4 left-1/4 w-64 h-64 bg-primary/10 rounded-full blur-3xl animate-pulse" />
            <div className="absolute bottom-1/4 right-1/4 w-96 h-96 bg-accent/10 rounded-full blur-3xl animate-pulse" style={{ animationDelay: '1s' }} />
          </div>
          
          <div className="text-center space-y-4">
            <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-primary/10 border border-primary/20 mb-4 animate-scale-in">
              <Sparkles className="w-4 h-4 text-primary" />
              <span className="text-sm font-medium text-primary">AI-Powered Coaching</span>
            </div>
            <h1 className="text-6xl font-bold bg-gradient-to-r from-primary via-accent to-primary bg-clip-text text-transparent bg-[length:200%_auto]">
              Ready to Practice?
            </h1>
            <p className="text-xl text-muted-foreground max-w-2xl">
              Start a conversation with AI and transform your speaking skills
            </p>
          </div>
          
          <div className="relative group">
            <div className="absolute inset-0 bg-gradient-to-r from-primary to-accent rounded-full blur-xl group-hover:blur-2xl transition-all opacity-50 group-hover:opacity-75" />
            <Button 
              size="xl" 
              variant="hero" 
              className="relative hover:scale-105 transition-transform duration-300"
              onClick={isListening ? stopSession : startSession}
            >
              {isListening ? (
                <>
                  <Square className="w-7 h-7 fill-current" />
                  Stop Conversation
                </>
              ) : (
                <>
                  <Mic className="w-7 h-7" />
                  Start Conversation Now
                </>
              )}
            </Button>
          </div>
          
          {isListening && (
            <WaveformVisualizer 
              isActive={isListening}
              status="listening"
            />
          )}
          
          {isConnected && (
            <div className="text-sm text-muted-foreground">
              <span className="inline-flex items-center gap-2">
                <span className="w-2 h-2 bg-green-500 rounded-full animate-pulse" />
                Connected
              </span>
            </div>
          )}
          
          <audio ref={audioRef} className="hidden" />
          
          <div className="flex items-center gap-8 text-sm text-muted-foreground">
            <div className="flex items-center gap-2">
              <Clock className="w-4 h-4" />
              <span>5-15 min sessions</span>
            </div>
            <div className="flex items-center gap-2">
              <Target className="w-4 h-4" />
              <span>Personalized feedback</span>
            </div>
            <div className="flex items-center gap-2">
              <BarChart3 className="w-4 h-4" />
              <span>Track progress</span>
            </div>
          </div>
        </div>

        {/* Greeting Header */}
        <div className="space-y-2 pt-8 border-t">
          <h2 className="text-3xl font-bold text-foreground">Welcome back, Chetan 👋</h2>
          <p className="text-muted-foreground">Keep up the great progress!</p>
        </div>

        {/* Quick Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {stats.map((stat, index) => (
            <Card 
              key={index} 
              className="group bg-card hover:shadow-2xl hover:shadow-primary/20 transition-all duration-300 hover:-translate-y-1 border-2 hover:border-primary/50 animate-fade-in"
              style={{ animationDelay: `${index * 100}ms` }}
            >
              <CardHeader>
                <CardTitle className="text-lg flex items-center justify-between">
                  {stat.title}
                  <Award className="w-5 h-5 text-primary opacity-0 group-hover:opacity-100 transition-opacity" />
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="flex items-baseline gap-2">
                  <span className={`text-5xl font-bold bg-gradient-to-r ${stat.color} bg-clip-text text-transparent transition-all group-hover:scale-110`}>
                    {stat.value}
                  </span>
                  <span className="text-muted-foreground text-lg">/ {stat.max}</span>
                </div>
                <Progress value={(parseFloat(stat.value) / parseFloat(stat.max)) * 100} className="h-3" />
              </CardContent>
            </Card>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Recent Sessions */}
          <Card className="border-2 hover:border-primary/30 transition-all">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <div className="p-2 rounded-lg bg-primary/10">
                  <Play className="w-5 h-5 text-primary" />
                </div>
                Recent Sessions
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-3">
              {recentSessions.map((session, index) => (
                <div 
                  key={index} 
                  className="group flex items-center justify-between p-4 rounded-xl bg-gradient-to-r from-muted/50 to-muted/30 hover:from-primary/10 hover:to-accent/10 transition-all duration-300 hover:scale-[1.02] cursor-pointer border border-transparent hover:border-primary/20"
                >
                  <div className="space-y-1">
                    <p className="font-semibold group-hover:text-primary transition-colors">{session.title}</p>
                    <p className="text-sm text-muted-foreground">{session.date} • {session.duration}</p>
                  </div>
                  <div className="flex items-center gap-4">
                    <div className="text-right">
                      <p className="text-3xl font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">{session.score}</p>
                      <p className="text-xs text-muted-foreground">Score</p>
                    </div>
                    <Button size="icon" variant="ghost" className="rounded-full group-hover:bg-primary/20 transition-colors">
                      <Play className="w-4 h-4 group-hover:text-primary transition-colors" />
                    </Button>
                  </div>
                </div>
              ))}
            </CardContent>
          </Card>

          {/* Weekly Progress Graph */}
          <Card className="border-2 hover:border-accent/30 transition-all">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <div className="p-2 rounded-lg bg-accent/10">
                  <TrendingUp className="w-5 h-5 text-accent" />
                </div>
                Weekly Progress
              </CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              {["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map((day, index) => {
                const value = Math.floor(Math.random() * 40 + 60);
                return (
                  <div 
                    key={day} 
                    className="group space-y-2 hover:scale-[1.02] transition-transform"
                    style={{ animationDelay: `${index * 50}ms` }}
                  >
                    <div className="flex justify-between text-sm">
                      <span className="font-medium group-hover:text-accent transition-colors">{day}</span>
                      <span className="font-bold text-accent">{value}%</span>
                    </div>
                    <Progress value={value} className="h-3 group-hover:h-4 transition-all" />
                  </div>
                );
              })}
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
