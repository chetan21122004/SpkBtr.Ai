import { useEffect, useState, useRef } from "react";

interface WaveformVisualizerProps {
  isActive: boolean;
  status: "listening" | "analyzing" | "idle";
}

const WaveformVisualizer = ({ isActive, status }: WaveformVisualizerProps) => {
  const [audioData, setAudioData] = useState<number[]>(Array(20).fill(5));
  const audioContextRef = useRef<AudioContext | null>(null);
  const analyserRef = useRef<AnalyserNode | null>(null);
  const streamRef = useRef<MediaStream | null>(null);
  const animationFrameRef = useRef<number | null>(null);
  const previousDataRef = useRef<number[]>(Array(20).fill(5));

  useEffect(() => {
    if (!isActive) {
      // Cleanup when inactive
      if (animationFrameRef.current) {
        cancelAnimationFrame(animationFrameRef.current);
        animationFrameRef.current = null;
      }
      if (streamRef.current) {
        streamRef.current.getTracks().forEach(track => track.stop());
        streamRef.current = null;
      }
      if (audioContextRef.current && audioContextRef.current.state !== "closed") {
        audioContextRef.current.close().catch(() => {});
        audioContextRef.current = null;
      }
      analyserRef.current = null;
      setAudioData(Array(20).fill(5));
      previousDataRef.current = Array(20).fill(5);
      return;
    }

    // Initialize audio context and microphone
    const initAudio = async () => {
      try {
        // Request microphone access with better constraints
        const stream = await navigator.mediaDevices.getUserMedia({ 
          audio: {
            echoCancellation: true,
            noiseSuppression: true,
            autoGainControl: true,
          } 
        });
        streamRef.current = stream;

        // Create audio context
        const AudioContextClass = window.AudioContext || (window as any).webkitAudioContext;
        const audioContext = new AudioContextClass();
        audioContextRef.current = audioContext;

        // Create analyser node with better settings
        const analyser = audioContext.createAnalyser();
        analyser.fftSize = 256; // Higher fftSize for better frequency resolution
        analyser.smoothingTimeConstant = 0.6; // Lower smoothing for more responsive visualization
        analyser.minDecibels = -90;
        analyser.maxDecibels = -10;
        analyserRef.current = analyser;

        // Connect microphone to analyser
        const source = audioContext.createMediaStreamSource(stream);
        source.connect(analyser);

        // Start analyzing audio
        const dataArray = new Uint8Array(analyser.frequencyBinCount);
        const barCount = 20;
        
        const updateAudioData = () => {
          if (!analyserRef.current || !isActive) return;

          // Get frequency data
          analyserRef.current.getByteFrequencyData(dataArray);
          
          // Map frequency data to 20 bars with better distribution
          const binCount = dataArray.length;
          const binsPerBar = Math.ceil(binCount / barCount);
          const newAudioData: number[] = [];

          for (let i = 0; i < barCount; i++) {
            let sum = 0;
            let max = 0;
            const start = i * binsPerBar;
            const end = Math.min(start + binsPerBar, binCount);
            
            for (let j = start; j < end; j++) {
              const value = dataArray[j];
              sum += value;
              max = Math.max(max, value);
            }
            
            // Use max value for more responsive visualization
            const average = max; // Using max instead of average for better reactivity
            const normalized = Math.min(100, (average / 255) * 100);
            
            // Apply exponential smoothing with previous data
            const previous = previousDataRef.current[i] || 5;
            const smoothed = previous * 0.3 + normalized * 0.7;
            
            // Ensure minimum height for visibility, but allow it to go lower when quiet
            const finalHeight = Math.max(5, smoothed);
            newAudioData.push(finalHeight);
          }

          previousDataRef.current = newAudioData;
          setAudioData(newAudioData);
          animationFrameRef.current = requestAnimationFrame(updateAudioData);
        };

        updateAudioData();
      } catch (error) {
        console.error("Error accessing microphone:", error);
        // Fallback to subtle animation if microphone access fails
        const fallbackUpdate = () => {
          if (!isActive) return;
          setAudioData(Array.from({ length: 20 }, () => Math.random() * 30 + 20));
          animationFrameRef.current = requestAnimationFrame(fallbackUpdate);
        };
        fallbackUpdate();
      }
    };

    initAudio();

    return () => {
      // Cleanup on unmount
      if (animationFrameRef.current) {
        cancelAnimationFrame(animationFrameRef.current);
      }
      if (streamRef.current) {
        streamRef.current.getTracks().forEach(track => track.stop());
      }
      if (audioContextRef.current && audioContextRef.current.state !== "closed") {
        audioContextRef.current.close().catch(() => {});
      }
    };
  }, [isActive]);

  if (!isActive) return null;

  return (
    <div className="flex flex-col items-center gap-6 animate-fade-in">
      <div className="flex items-center gap-1 h-32">
        {audioData.map((height, i) => (
          <div
            key={i}
            className="w-2 bg-gradient-to-t from-primary to-accent rounded-full transition-all duration-100 ease-out"
            style={{
              height: `${height}%`,
              minHeight: "4px",
            }}
          />
        ))}
      </div>
      <div className="text-center">
        <p className="text-lg font-medium text-foreground">
          {status === "listening" && "Listening..."}
          {status === "analyzing" && "Analyzing..."}
          {status === "idle" && "Ready"}
        </p>
        <p className="text-sm text-muted-foreground mt-1">
          Speak naturally and clearly
        </p>
      </div>
    </div>
  );
};

export default WaveformVisualizer;
