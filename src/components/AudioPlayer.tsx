import { useState, useRef, useEffect } from "react";
import { Play, Pause, Volume2, VolumeX } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Slider } from "@/components/ui/slider";
import { cn } from "@/lib/utils";

interface AudioPlayerProps {
  audioUrl: string;
  duration?: number | null;
  className?: string;
  compact?: boolean;
}

export const AudioPlayer = ({ audioUrl, duration, className, compact = false }: AudioPlayerProps) => {
  const audioRef = useRef<HTMLAudioElement | null>(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [audioDuration, setAudioDuration] = useState(duration || 0);
  const [volume, setVolume] = useState(1);
  const [isMuted, setIsMuted] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Initialize audio element
  useEffect(() => {
    if (!audioUrl) {
      setError("No audio URL provided");
      return;
    }

    // Validate URL format before creating Audio element
    if (!audioUrl.startsWith('http://') && !audioUrl.startsWith('https://')) {
      console.error("❌ Invalid audio URL format:", audioUrl);
      setError(`Invalid audio URL format: ${audioUrl}`);
      return;
    }

    console.log("🎵 Initializing audio player:", audioUrl);
    const audio = new Audio(audioUrl);
    audioRef.current = audio;

    // Fix for duration not showing: Set initial currentTime to force metadata loading
    audio.currentTime = Number.MAX_SAFE_INTEGER;

    // Event listeners
    const handleLoadedMetadata = () => {
      // Reset currentTime after metadata loads
      audio.currentTime = 0;
      const loadedDuration = audio.duration && isFinite(audio.duration) 
        ? audio.duration 
        : (duration || 0);
      setAudioDuration(loadedDuration);
      setIsLoading(false);
      setError(null);
    };

    const handleTimeUpdate = () => {
      setCurrentTime(audio.currentTime);
    };

    const handleEnded = () => {
      setIsPlaying(false);
      setCurrentTime(0);
    };

    const handleError = (e: Event) => {
      const audio = e.target as HTMLAudioElement;
      const error = audio.error;
      
      let errorMessage = "Failed to load audio.";
      let errorDetails = "";
      let errorCode = "UNKNOWN";
      
      if (error) {
        switch (error.code) {
          case MediaError.MEDIA_ERR_ABORTED:
            errorCode = "ABORTED";
            errorMessage = "Audio loading was aborted.";
            break;
          case MediaError.MEDIA_ERR_NETWORK:
            errorCode = "NETWORK";
            errorMessage = "Network error while loading audio.";
            errorDetails = "Please check your internet connection and try again.";
            break;
          case MediaError.MEDIA_ERR_DECODE:
            errorCode = "DECODE";
            errorMessage = "Audio decoding error.";
            errorDetails = "The audio file may be corrupted or in an unsupported format.";
            break;
          case MediaError.MEDIA_ERR_SRC_NOT_SUPPORTED:
            errorCode = "SRC_NOT_SUPPORTED";
            errorMessage = "Audio format not supported or URL not accessible.";
            errorDetails = `URL: ${audioUrl}`;
            break;
          default:
            errorCode = `CODE_${error.code}`;
            errorMessage = "Unknown audio error occurred.";
        }
        
        console.error("🔴 Audio error details:", {
          code: error.code,
          errorCode,
          message: errorMessage,
          audioSrc: audio.src,
          networkState: audio.networkState,
          readyState: audio.readyState,
          url: audioUrl
        });
      } else {
        console.error("🔴 Audio error event (no error object):", e);
        console.error("Audio element state:", {
          src: audio.src,
          networkState: audio.networkState,
          readyState: audio.readyState,
          url: audioUrl
        });
      }
      
      setIsLoading(false);
      setIsPlaying(false);
      setError(`${errorMessage} ${errorDetails ? `(${errorDetails})` : ''}`);
    };

    const handleCanPlay = () => {
      setIsLoading(false);
      console.log("✅ Audio can play");
      // Ensure duration is set even if loadedmetadata didn't fire
      if (audio.duration && isFinite(audio.duration) && audioDuration === 0) {
        setAudioDuration(audio.duration);
      }
    };
    
    const handlePlay = () => {
      // Reset currentTime when playing starts (fix from Stack Overflow)
      if (audio.currentTime === Number.MAX_SAFE_INTEGER) {
        audio.currentTime = 0;
      }
    };

    const handleLoadStart = () => {
      setIsLoading(true);
      console.log("🔄 Audio loading started");
    };

    const handleProgress = () => {
      if (audio.networkState === HTMLMediaElement.NETWORK_LOADING) {
        console.log("📥 Loading audio data...");
      } else if (audio.networkState === HTMLMediaElement.NETWORK_NO_SOURCE) {
        console.warn("⚠️ No audio source available");
      }
    };

    audio.addEventListener("loadedmetadata", handleLoadedMetadata);
    audio.addEventListener("timeupdate", handleTimeUpdate);
    audio.addEventListener("ended", handleEnded);
    audio.addEventListener("error", handleError);
    audio.addEventListener("canplay", handleCanPlay);
    audio.addEventListener("loadstart", handleLoadStart);
    audio.addEventListener("progress", handleProgress);
    audio.addEventListener("play", handlePlay);
    
    // Force load to trigger metadata loading
    audio.load();

    // Set initial volume
    audio.volume = volume;
    audio.muted = isMuted;

    return () => {
      audio.removeEventListener("loadedmetadata", handleLoadedMetadata);
      audio.removeEventListener("timeupdate", handleTimeUpdate);
      audio.removeEventListener("ended", handleEnded);
      audio.removeEventListener("error", handleError as EventListener);
      audio.removeEventListener("canplay", handleCanPlay);
      audio.removeEventListener("loadstart", handleLoadStart);
      audio.removeEventListener("play", handlePlay);
      audio.pause();
      audio.src = "";
    };
  }, [audioUrl, duration]);

  const togglePlayPause = async () => {
    if (!audioRef.current) return;

    try {
      if (isPlaying) {
        audioRef.current.pause();
        setIsPlaying(false);
      } else {
        await audioRef.current.play();
        setIsPlaying(true);
      }
    } catch (err) {
      console.error("Error playing audio:", err);
      setError("Failed to play audio");
      setIsPlaying(false);
    }
  };

  const handleSeek = (value: number[]) => {
    if (!audioRef.current) return;
    const newTime = value[0];
    audioRef.current.currentTime = newTime;
    setCurrentTime(newTime);
  };

  const handleVolumeChange = (value: number[]) => {
    if (!audioRef.current) return;
    const newVolume = value[0];
    audioRef.current.volume = newVolume;
    setVolume(newVolume);
    setIsMuted(newVolume === 0);
  };

  const toggleMute = () => {
    if (!audioRef.current) return;
    const newMuted = !isMuted;
    audioRef.current.muted = newMuted;
    setIsMuted(newMuted);
  };

  const formatTime = (seconds: number): string => {
    if (isNaN(seconds)) return "0:00";
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, "0")}`;
  };

  if (compact) {
    return (
      <div className={cn("flex items-center gap-2", className)}>
        <Button
          variant="outline"
          size="icon"
          onClick={togglePlayPause}
          disabled={isLoading || !!error}
          className="h-8 w-8"
        >
          {isLoading ? (
            <div className="h-4 w-4 animate-spin rounded-full border-2 border-current border-t-transparent" />
          ) : isPlaying ? (
            <Pause className="h-4 w-4" />
          ) : (
            <Play className="h-4 w-4" />
          )}
        </Button>
        {error ? (
          <span className="text-xs text-destructive">{error}</span>
        ) : (
          <span className="text-xs text-muted-foreground">
            {formatTime(currentTime)} / {formatTime(audioDuration)}
          </span>
        )}
      </div>
    );
  }

  return (
    <div className={cn("space-y-2 p-4 border rounded-lg bg-card", className)}>
      {error && (
        <div className="text-sm text-destructive bg-destructive/10 p-2 rounded">
          {error}
        </div>
      )}
      
      <div className="flex items-center gap-3">
        <Button
          variant="outline"
          size="icon"
          onClick={togglePlayPause}
          disabled={isLoading || !!error}
        >
          {isLoading ? (
            <div className="h-4 w-4 animate-spin rounded-full border-2 border-current border-t-transparent" />
          ) : isPlaying ? (
            <Pause className="h-4 w-4" />
          ) : (
            <Play className="h-4 w-4" />
          )}
        </Button>

        <div className="flex-1 space-y-1">
          <Slider
            value={[currentTime]}
            max={audioDuration || 100}
            step={0.1}
            onValueChange={handleSeek}
            disabled={!audioRef.current || !!error}
            className="w-full"
          />
          <div className="flex justify-between text-xs text-muted-foreground">
            <span>{formatTime(currentTime)}</span>
            <span>{formatTime(audioDuration)}</span>
          </div>
        </div>

        <div className="flex items-center gap-2">
          <Button
            variant="ghost"
            size="icon"
            onClick={toggleMute}
            className="h-8 w-8"
          >
            {isMuted ? (
              <VolumeX className="h-4 w-4" />
            ) : (
              <Volume2 className="h-4 w-4" />
            )}
          </Button>
          <Slider
            value={[volume]}
            max={1}
            step={0.01}
            onValueChange={handleVolumeChange}
            className="w-20"
          />
        </div>
      </div>
    </div>
  );
};

