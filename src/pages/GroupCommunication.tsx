import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import { Mic, MicOff, Loader2 } from "lucide-react";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useAuth } from "@/hooks/useAuth";
import AISpeakingAnimation from "@/components/AISpeakingAnimation";

const GroupCommunication = () => {
  const { user } = useAuth();
  const [isLoading, setIsLoading] = useState(false);
  const { audioRef, isListening, startSession, stopSession, isAISpeaking } = useVoiceConversation({
    categoryName: "Group Communication",
    userId: user?.id,
  });
  const [isSpeaking, setIsSpeaking] = useState(false);

  const teamMembers = [
    { name: "Sarah", role: "Manager", color: "from-blue-500 to-cyan-500", speaking: false },
    { name: "Mike", role: "Developer", color: "from-green-500 to-emerald-500", speaking: true },
    { name: "Lisa", role: "Designer", color: "from-purple-500 to-pink-500", speaking: false },
    { name: "You", role: "Team Member", color: "from-primary to-accent", speaking: isSpeaking },
  ];

  const stats = [
    { label: "Speaking Time", value: "25%", color: "primary" },
    { label: "Clarity Score", value: "88%", color: "accent" },
    { label: "Interruptions", value: "2", color: "muted" },
  ];

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-6xl mx-auto space-y-6">
        <div className="text-center space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Group Communication</h1>
          <p className="text-muted-foreground">Practice speaking in team settings</p>
        </div>

        {/* AI Speaking Animation */}
        <AISpeakingAnimation 
          isListening={isListening}
          audioRef={audioRef}
          categoryName="Group Communication"
          size="large"
          onLoadingChange={setIsLoading}
        />

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Team Members */}
          <div className="lg:col-span-2 space-y-4">
            <Card>
              <CardContent className="p-6">
                <h3 className="text-lg font-semibold mb-4">Team Members</h3>
                <div className="grid grid-cols-2 gap-4">
                  {teamMembers.map((member, index) => (
                    <div 
                      key={index}
                      className={`relative p-4 rounded-lg border-2 transition-all ${
                        member.speaking 
                          ? 'border-primary shadow-lg scale-105' 
                          : 'border-border'
                      }`}
                    >
                      <div className="flex items-center gap-3">
                        <Avatar className="w-12 h-12">
                          <AvatarFallback className={`bg-gradient-to-br ${member.color} text-white`}>
                            {member.name[0]}
                          </AvatarFallback>
                        </Avatar>
                        <div>
                          <p className="font-semibold">{member.name}</p>
                          <p className="text-sm text-muted-foreground">{member.role}</p>
                        </div>
                      </div>
                      {member.speaking && (
                        <div className="absolute top-2 right-2">
                          <Mic className="w-5 h-5 text-primary animate-pulse" />
                        </div>
                      )}
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6 space-y-4">
                <div className="text-center space-y-4">
                  <Button 
                    size="lg"
                    onClick={isListening ? stopSession : startSession}
                    variant={isListening ? "destructive" : "default"}
                    className="rounded-full"
                    disabled={isLoading && !isListening}
                  >
                    {isLoading && !isListening ? (
                      <>
                        <Loader2 className="w-5 h-5 mr-2 animate-spin" />
                        Connecting...
                      </>
                    ) : isListening ? (
                      <>
                        <MicOff className="w-5 h-5 mr-2" />
                        Stop Session
                      </>
                    ) : (
                      <>
                        <Mic className="w-5 h-5 mr-2" />
                        Start Coaching Session
                      </>
                    )}
                  </Button>
                </div>

                <WaveformVisualizer 
                  isActive={isListening}
                  status={isListening ? "listening" : "idle"}
                />
                <audio ref={audioRef} className="hidden" />
              </CardContent>
            </Card>
          </div>

          {/* Side Stats */}
          <div className="space-y-4">
            <Card>
              <CardContent className="p-6 space-y-6">
                <h3 className="text-lg font-semibold">Session Stats</h3>
                {stats.map((stat, index) => (
                  <div key={index} className="space-y-2">
                    <div className="flex justify-between">
                      <span className="text-sm text-muted-foreground">{stat.label}</span>
                      <span className="font-bold text-primary">{stat.value}</span>
                    </div>
                    <Progress value={parseInt(stat.value)} />
                  </div>
                ))}
              </CardContent>
            </Card>

            <Card>
              <CardContent className="p-6 space-y-3">
                <h3 className="text-lg font-semibold">Tips</h3>
                <ul className="space-y-2 text-sm text-muted-foreground">
                  <li>✓ Wait for natural pauses</li>
                  <li>✓ Maintain steady pace</li>
                  <li>✓ Make eye contact (camera)</li>
                  <li>✓ Use clear articulation</li>
                </ul>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  );
};

export default GroupCommunication;
