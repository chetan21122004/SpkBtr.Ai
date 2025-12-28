import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Card, CardContent } from "@/components/ui/card";

const AITypingIndicator = () => {
  return (
    <div className="flex gap-3">
      <Avatar className="w-10 h-10">
        <AvatarFallback className="bg-gradient-to-br from-primary to-accent text-white">
          AI
        </AvatarFallback>
      </Avatar>

      <div className="flex flex-col gap-2 max-w-[70%]">
        <Card className="bg-muted">
          <CardContent className="p-4">
            <div className="flex items-center justify-center w-12 h-12">
              <div className="relative w-8 h-8">
                {/* Outer ring - ping animation */}
                <div className="absolute inset-0 rounded-full bg-primary/20 animate-ping" />
                {/* Middle ring - pulse animation */}
                <div className="absolute inset-1 rounded-full bg-primary/40 animate-pulse" />
                {/* Inner solid circle */}
                <div className="absolute inset-2 rounded-full bg-primary" />
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
};

export default AITypingIndicator;


