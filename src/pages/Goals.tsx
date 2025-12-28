import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { Badge } from "@/components/ui/badge";
import { Target, Flame, Award, CheckCircle2 } from "lucide-react";

const Goals = () => {
  const challenges = [
    { 
      title: "Speak confidently for 2 mins", 
      progress: 60, 
      completed: false,
      streak: 3,
      badge: "🎯"
    },
    { 
      title: "Record daily for 5 days", 
      progress: 80, 
      completed: false,
      streak: 4,
      badge: "🔥"
    },
    { 
      title: "Complete 3 interview practices", 
      progress: 66, 
      completed: false,
      streak: 2,
      badge: "💼"
    },
    { 
      title: "Achieve 90% fluency score", 
      progress: 100, 
      completed: true,
      streak: 7,
      badge: "⭐"
    },
    { 
      title: "Practice pronunciation 10 words", 
      progress: 40, 
      completed: false,
      streak: 4,
      badge: "🗣️"
    },
  ];

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="space-y-2">
          <h1 className="text-4xl font-bold text-foreground flex items-center gap-3">
            <Target className="w-10 h-10 text-primary" />
            Your Weekly Goals
          </h1>
          <p className="text-muted-foreground">Complete challenges to unlock badges and improve your skills</p>
        </div>

        {/* Streak Counter */}
        <Card className="bg-gradient-to-r from-orange-500/10 to-red-500/10 border-orange-500/20">
          <CardContent className="flex items-center justify-between p-6">
            <div className="flex items-center gap-4">
              <Flame className="w-12 h-12 text-orange-500" />
              <div>
                <h3 className="text-2xl font-bold">7 Day Streak! 🔥</h3>
                <p className="text-muted-foreground">Keep it going!</p>
              </div>
            </div>
            <Badge variant="secondary" className="text-lg px-4 py-2">
              <Award className="w-4 h-4 mr-2" />
              Level 5
            </Badge>
          </CardContent>
        </Card>

        {/* Challenges List */}
        <div className="space-y-4">
          {challenges.map((challenge, index) => (
            <Card key={index} className={challenge.completed ? "bg-primary/5 border-primary/20" : ""}>
              <CardHeader>
                <CardTitle className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <span className="text-3xl">{challenge.badge}</span>
                    <div>
                      <h3 className="text-lg font-semibold">{challenge.title}</h3>
                      <div className="flex items-center gap-2 mt-1">
                        <Flame className="w-4 h-4 text-orange-500" />
                        <span className="text-sm text-muted-foreground">{challenge.streak} day streak</span>
                      </div>
                    </div>
                  </div>
                  {challenge.completed && (
                    <CheckCircle2 className="w-8 h-8 text-primary" />
                  )}
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">Progress</span>
                  <span className="font-medium">{challenge.progress}%</span>
                </div>
                <Progress value={challenge.progress} />
                {!challenge.completed && (
                  <Button className="w-full" variant={index === 0 ? "default" : "outline"}>
                    {index === 0 ? "Continue Challenge" : "Start Challenge"}
                  </Button>
                )}
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Goals;
