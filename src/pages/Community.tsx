import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Badge } from "@/components/ui/badge";
import { Heart, MessageCircle, Play, TrendingUp } from "lucide-react";

const Community = () => {
  const posts = [
    {
      user: "Sarah M.",
      avatar: "SM",
      time: "2 hours ago",
      category: "Public Speaking",
      achievement: "Achieved 95% confidence score!",
      likes: 24,
      comments: 8,
      trending: true,
      color: "from-purple-500 to-pink-500"
    },
    {
      user: "Mike Chen",
      avatar: "MC",
      time: "5 hours ago",
      category: "Interview Practice",
      achievement: "Completed 30-day practice streak 🔥",
      likes: 42,
      comments: 15,
      trending: true,
      color: "from-blue-500 to-cyan-500"
    },
    {
      user: "Lisa Park",
      avatar: "LP",
      time: "Yesterday",
      category: "Voice Clarity",
      achievement: "Perfect pronunciation on 50 difficult words",
      likes: 18,
      comments: 6,
      trending: false,
      color: "from-green-500 to-emerald-500"
    },
    {
      user: "Alex Johnson",
      avatar: "AJ",
      time: "2 days ago",
      category: "Emotional Expression",
      achievement: "Mastered conveying empathy naturally",
      likes: 31,
      comments: 12,
      trending: false,
      color: "from-pink-500 to-red-500"
    },
  ];

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-4xl mx-auto space-y-6">
        <div className="space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Community</h1>
          <p className="text-muted-foreground">Share your progress and inspire others</p>
        </div>

        {/* AI Community Moderator */}
        <Card className="bg-gradient-to-r from-primary to-accent text-white">
          <CardContent className="p-6">
            <div className="flex items-center gap-4">
              <Avatar className="w-12 h-12 border-2 border-white">
                <AvatarFallback className="bg-white text-primary font-bold">AI</AvatarFallback>
              </Avatar>
              <div className="flex-1">
                <h3 className="font-semibold">Community Tip of the Day</h3>
                <p className="text-white/90 text-sm">
                  Practice your speech in front of a mirror to build confidence and observe your body language!
                </p>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Share Your Progress Button */}
        <Button className="w-full" size="lg">
          Share Your Progress
        </Button>

        {/* Posts Feed */}
        <div className="space-y-4">
          {posts.map((post, index) => (
            <Card key={index} className="hover:shadow-lg transition-shadow">
              <CardContent className="p-6 space-y-4">
                {/* Post Header */}
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <Avatar>
                      <AvatarFallback className={`bg-gradient-to-br ${post.color} text-white`}>
                        {post.avatar}
                      </AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-semibold">{post.user}</p>
                      <p className="text-sm text-muted-foreground">{post.time}</p>
                    </div>
                  </div>
                  {post.trending && (
                    <Badge variant="secondary" className="gap-1">
                      <TrendingUp className="w-3 h-3" />
                      Trending
                    </Badge>
                  )}
                </div>

                {/* Post Content */}
                <div className="space-y-2">
                  <Badge>{post.category}</Badge>
                  <p className="text-lg">{post.achievement}</p>
                </div>

                {/* Audio Player (Optional) */}
                <div className="flex items-center gap-2 p-3 bg-muted rounded-lg">
                  <Button variant="ghost" size="icon" className="rounded-full">
                    <Play className="w-4 h-4" />
                  </Button>
                  <div className="flex-1 h-2 bg-background rounded-full overflow-hidden">
                    <div 
                      className={`h-full bg-gradient-to-r ${post.color}`}
                      style={{ width: "40%" }}
                    />
                  </div>
                  <span className="text-xs text-muted-foreground">0:45</span>
                </div>

                {/* Post Actions */}
                <div className="flex items-center gap-6 pt-2">
                  <Button variant="ghost" size="sm" className="gap-2">
                    <Heart className="w-4 h-4" />
                    <span>{post.likes} Cheers</span>
                  </Button>
                  <Button variant="ghost" size="sm" className="gap-2">
                    <MessageCircle className="w-4 h-4" />
                    <span>{post.comments} Comments</span>
                  </Button>
                </div>

                {/* AI Comment */}
                {index === 0 && (
                  <Card className="bg-primary/5 border-primary/20">
                    <CardContent className="p-3 flex gap-2">
                      <Avatar className="w-6 h-6">
                        <AvatarFallback className="bg-primary text-white text-xs">AI</AvatarFallback>
                      </Avatar>
                      <div>
                        <p className="text-sm font-medium">AI Coach</p>
                        <p className="text-sm text-muted-foreground">
                          Amazing progress! Your dedication is inspiring the community! 🌟
                        </p>
                      </div>
                    </CardContent>
                  </Card>
                )}
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Community;
