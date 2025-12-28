import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { TrendingUp, TrendingDown, ArrowRight, Loader2 } from "lucide-react";
import { useProgress } from "@/hooks/useProgress";

const Progress = () => {
  const { weeklyData, improvements, overallStats, loading, error } = useProgress();

  // Default data for empty state
  const defaultWeeklyData = [
    { day: "Sun", tone: 0, confidence: 0, fluency: 0 },
    { day: "Mon", tone: 0, confidence: 0, fluency: 0 },
    { day: "Tue", tone: 0, confidence: 0, fluency: 0 },
    { day: "Wed", tone: 0, confidence: 0, fluency: 0 },
    { day: "Thu", tone: 0, confidence: 0, fluency: 0 },
    { day: "Fri", tone: 0, confidence: 0, fluency: 0 },
    { day: "Sat", tone: 0, confidence: 0, fluency: 0 },
  ];

  const displayWeeklyData = weeklyData.length > 0 ? weeklyData : defaultWeeklyData;
  const hasData = overallStats.totalSessions > 0;

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-6xl mx-auto space-y-6">
        <div className="flex items-center justify-between">
          <div className="space-y-2">
            <h1 className="text-4xl font-bold text-foreground">Progress Analytics</h1>
            <p className="text-muted-foreground">Track your improvement over time (IST)</p>
          </div>
          <Button>
            View Detailed History
            <ArrowRight className="w-4 h-4 ml-2" />
          </Button>
        </div>

        {loading && (
          <div className="flex items-center justify-center py-12">
            <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
          </div>
        )}

        {error && (
          <Card>
            <CardContent className="p-6">
              <p className="text-destructive">Error: {error}</p>
            </CardContent>
          </Card>
        )}

        {!loading && !error && !hasData && (
          <Card>
            <CardContent className="p-12 text-center">
              <p className="text-muted-foreground">
                No progress data yet. Start practicing to see your analytics here!
              </p>
            </CardContent>
          </Card>
        )}

        {!loading && !error && (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          {/* Weekly Chart */}
          <Card className="md:col-span-2">
            <CardHeader>
              <CardTitle>Weekly Performance</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-6">
                {["Tone", "Confidence", "Fluency"].map((metric, metricIndex) => (
                  <div key={metric} className="space-y-2">
                    <div className="flex justify-between text-sm font-medium">
                      <span>{metric}</span>
                      <span className="text-primary">
                        {displayWeeklyData.length > 0 
                          ? displayWeeklyData[displayWeeklyData.length - 1][metric.toLowerCase() as keyof typeof displayWeeklyData[0]] || 0
                          : 0}%
                      </span>
                    </div>
                    <div className="flex gap-2 h-32 items-end">
                      {displayWeeklyData.map((data, index) => {
                        const value = data[metric.toLowerCase() as keyof typeof data] as number;
                        const displayValue = value > 0 ? value : 0;
                        return (
                          <div key={index} className="flex-1 flex flex-col items-center gap-2">
                            <div 
                              className={`w-full rounded-t-lg bg-gradient-to-t ${
                                displayValue === 0 ? 'bg-muted' :
                                metricIndex === 0 ? 'from-purple-500 to-pink-500' :
                                metricIndex === 1 ? 'from-blue-500 to-cyan-500' :
                                'from-green-500 to-emerald-500'
                              }`}
                              style={{ height: displayValue > 0 ? `${Math.max(displayValue, 10)}%` : '5px' }}
                            />
                            <span className="text-xs text-muted-foreground">{data.day}</span>
                          </div>
                        );
                      })}
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          {/* Top Improvements */}
          <Card>
            <CardHeader>
              <CardTitle>Top Improvement Areas</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              {improvements.map((item, index) => (
                <div key={index} className="flex items-center justify-between p-4 rounded-lg bg-muted">
                  <div className="flex items-center gap-3">
                    {item.trend === "up" ? (
                      <TrendingUp className="w-5 h-5 text-green-500" />
                    ) : (
                      <TrendingDown className="w-5 h-5 text-red-500" />
                    )}
                    <span className="font-medium">{item.area}</span>
                  </div>
                  <span className={`font-bold ${
                    item.trend === "up" ? "text-green-500" : "text-red-500"
                  }`}>
                    {item.change}
                  </span>
                </div>
              ))}
            </CardContent>
          </Card>

          {/* Overall Stats */}
          <Card>
            <CardHeader>
              <CardTitle>Overall Statistics</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <p className="text-sm text-muted-foreground">Total Sessions</p>
                  <p className="text-3xl font-bold text-primary">{overallStats.totalSessions}</p>
                </div>
                <div className="space-y-2">
                  <p className="text-sm text-muted-foreground">Practice Time</p>
                  <p className="text-3xl font-bold text-primary">{overallStats.practiceTime}</p>
                </div>
                <div className="space-y-2">
                  <p className="text-sm text-muted-foreground">Current Streak</p>
                  <p className="text-3xl font-bold text-primary">
                    {overallStats.currentStreak > 0 ? `${overallStats.currentStreak}🔥` : '0'}
                  </p>
                </div>
                <div className="space-y-2">
                  <p className="text-sm text-muted-foreground">Avg Score</p>
                  <p className="text-3xl font-bold text-primary">{overallStats.avgScore}%</p>
                </div>
              </div>
            </CardContent>
          </Card>
          </div>
        )}
      </div>
    </div>
  );
};

export default Progress;
