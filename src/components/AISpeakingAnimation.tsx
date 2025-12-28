import { useEffect, useState, useRef } from "react";
import { getCategoryColors } from "@/utils/categoryColors";

interface AISpeakingAnimationProps {
  isListening: boolean;
  audioRef: React.RefObject<HTMLAudioElement>;
  categoryName?: string;
  size?: "small" | "medium" | "large";
  centerText?: string;
  colors?: { primary: string; accent: string };
  onLoadingChange?: (isLoading: boolean) => void;
}

const AISpeakingAnimation = ({
  isListening,
  audioRef,
  categoryName,
  size = "large",
  centerText,
  colors,
  onLoadingChange,
}: AISpeakingAnimationProps) => {
  const [audioVolume, setAudioVolume] = useState(0);
  const [isAudioPlaying, setIsAudioPlaying] = useState(false);
  const [hasReceivedFirstAudio, setHasReceivedFirstAudio] = useState(false);
  const audioContextRef = useRef<AudioContext | null>(null);
  const analyserRef = useRef<AnalyserNode | null>(null);
  const sourceRef = useRef<MediaElementAudioSourceNode | null>(null);
  const animationFrameRef = useRef<number | null>(null);
  const ringScalesRef = useRef<number[]>([1.0, 1.0, 1.0, 1.0, 1.0]);

  // Get colors from category mapping or use provided colors
  const categoryColors = colors || (categoryName ? getCategoryColors(categoryName) : { primary: "from-primary", accent: "to-accent" });
  const { primary, accent } = categoryColors;

  // Size configurations
  const sizeConfig = {
    large: {
      outer: "w-64 h-64",
      middle: "w-48 h-48",
      inner: "w-32 h-32",
      text: "text-xl",
    },
    medium: {
      outer: "w-48 h-48",
      middle: "w-36 h-36",
      inner: "w-24 h-24",
      text: "text-lg",
    },
    small: {
      outer: "w-32 h-32",
      middle: "w-24 h-24",
      inner: "w-16 h-16",
      text: "text-base",
    },
  };

  const config = sizeConfig[size];
  const displayText = centerText || "SpkBtr.Ai";

  // Audio analysis effect
  useEffect(() => {
    if (!isListening || !audioRef.current) {
      // Cleanup when not listening or no audio element
      if (animationFrameRef.current) {
        cancelAnimationFrame(animationFrameRef.current);
        animationFrameRef.current = null;
      }
      if (sourceRef.current) {
        try {
          sourceRef.current.disconnect();
        } catch (e) {
          // Already disconnected
        }
        sourceRef.current = null;
      }
      if (audioContextRef.current && audioContextRef.current.state !== "closed") {
        audioContextRef.current.close().catch(() => {});
        audioContextRef.current = null;
      }
      analyserRef.current = null;
      setAudioVolume(0);
      setIsAudioPlaying(false);
      setHasReceivedFirstAudio(false);
      ringScalesRef.current = [1.0, 1.0, 1.0, 1.0, 1.0];
      return;
    }

    const audioElement = audioRef.current;
    
    // Initialize audio context and analyser
    const initAudioAnalysis = async () => {
      try {
        const AudioContextClass = window.AudioContext || (window as any).webkitAudioContext;
        const audioContext = new AudioContextClass();
        audioContextRef.current = audioContext;

        // Create analyser node
        const analyser = audioContext.createAnalyser();
        analyser.fftSize = 256;
        analyser.smoothingTimeConstant = 0.6;
        analyser.minDecibels = -90;
        analyser.maxDecibels = -10;
        analyserRef.current = analyser;

        // Create source from audio element
        const source = audioContext.createMediaElementSource(audioElement);
        source.connect(analyser);
        analyser.connect(audioContext.destination);
        sourceRef.current = source;

        // Check if audio is playing (will be updated by updateAudioData with volume check)
        const checkAudioState = () => {
          // Initial state check, but actual detection happens in updateAudioData
          if (audioElement && !audioElement.paused && audioElement.currentTime > 0) {
            // Will be overridden by volume-based detection in updateAudioData
          } else {
            setIsAudioPlaying(false);
          }
        };

        // Monitor audio play/pause events (volume check will override in updateAudioData)
        const handlePlay = () => {
          // Will be updated by updateAudioData with volume threshold
        };
        const handlePause = () => setIsAudioPlaying(false);
        const handleEnded = () => setIsAudioPlaying(false);

        audioElement.addEventListener("play", handlePlay);
        audioElement.addEventListener("pause", handlePause);
        audioElement.addEventListener("ended", handleEnded);

        // Start analyzing audio
        const dataArray = new Uint8Array(analyser.frequencyBinCount);
        
        const updateAudioData = () => {
          if (!analyserRef.current || !isListening) {
            if (animationFrameRef.current) {
              cancelAnimationFrame(animationFrameRef.current);
              animationFrameRef.current = null;
            }
            return;
          }

          analyserRef.current.getByteFrequencyData(dataArray);
          
          // Calculate average volume with better sensitivity
          let sum = 0;
          let max = 0;
          for (let i = 0; i < dataArray.length; i++) {
            sum += dataArray[i];
            max = Math.max(max, dataArray[i]);
          }
          // Use both average and max for more responsive detection
          const average = sum / dataArray.length;
          const combinedVolume = (average * 0.7 + max * 0.3); // Weighted combination
          const normalizedVolume = Math.min(100, (combinedVolume / 255) * 100);
          
          // Update volume with less smoothing for more responsive visual feedback
          setAudioVolume(prev => {
            const smoothed = prev * 0.2 + normalizedVolume * 0.8; // More responsive (80% new, 20% old)
            return smoothed;
          });

          // Check if audio is actually playing (volume threshold for real audio)
          // Use smoothed volume for detection
          const currentVolume = audioVolume * 0.3 + normalizedVolume * 0.7;
          const hasAudio = currentVolume > 5; // Threshold for real audio signal
          const isActuallyPlaying = hasAudio && !audioElement.paused && audioElement.currentTime > 0;
          setIsAudioPlaying(isActuallyPlaying);

          // Track when we receive first audio
          if (hasAudio && !hasReceivedFirstAudio) {
            setHasReceivedFirstAudio(true);
          }

          // Update ring scales with different delays and sensitivities
          const baseScale = 1.0 + (normalizedVolume / 100) * 0.3; // Max 30% expansion
          
          // Ring 1: immediate reaction
          ringScalesRef.current[0] = baseScale;
          
          // Ring 2: 50ms delay, 0.8x sensitivity
          ringScalesRef.current[1] = 1.0 + (normalizedVolume / 100) * 0.3 * 0.8;
          
          // Ring 3: 100ms delay, 0.6x sensitivity
          ringScalesRef.current[2] = 1.0 + (normalizedVolume / 100) * 0.3 * 0.6;
          
          // Ring 4: 150ms delay, 0.4x sensitivity
          ringScalesRef.current[3] = 1.0 + (normalizedVolume / 100) * 0.3 * 0.4;
          
          // Ring 5: 200ms delay, 0.2x sensitivity
          ringScalesRef.current[4] = 1.0 + (normalizedVolume / 100) * 0.3 * 0.2;

          animationFrameRef.current = requestAnimationFrame(updateAudioData);
        };

        // Initial check
        checkAudioState();
        updateAudioData();

        // Cleanup function
        return () => {
          audioElement.removeEventListener("play", handlePlay);
          audioElement.removeEventListener("pause", handlePause);
          audioElement.removeEventListener("ended", handleEnded);
        };
      } catch (error) {
        console.error("Error initializing audio analysis:", error);
        setIsAudioPlaying(false);
      }
    };

    initAudioAnalysis();

    return () => {
      if (animationFrameRef.current) {
        cancelAnimationFrame(animationFrameRef.current);
        animationFrameRef.current = null;
      }
      if (sourceRef.current) {
        try {
          sourceRef.current.disconnect();
        } catch (e) {
          // Already disconnected
        }
        sourceRef.current = null;
      }
      if (audioContextRef.current && audioContextRef.current.state !== "closed") {
        audioContextRef.current.close().catch(() => {});
        audioContextRef.current = null;
      }
    };
  }, [isListening, audioRef]);

  // Smooth ring scales for animation
  const [ringScales, setRingScales] = useState([1.0, 1.0, 1.0, 1.0, 1.0]);
  
  useEffect(() => {
    const interval = setInterval(() => {
      setRingScales([...ringScalesRef.current]);
    }, 16); // ~60fps

    return () => clearInterval(interval);
  }, []);

  const showLoading = isListening && !hasReceivedFirstAudio;

  // Notify parent component about loading state
  useEffect(() => {
    if (onLoadingChange) {
      onLoadingChange(showLoading);
    }
  }, [showLoading, onLoadingChange]);

  return (
    <div className="flex justify-center py-12">
      <div className="relative">
        {/* Outer static circle - always visible */}
        <div
          className={`${config.outer} rounded-full bg-gradient-to-br ${primary}/20 ${accent}/20`}
        />
        
        {/* Waveform rings - react to audio */}
        {isListening && (
          <>
            {/* Ring 1 - immediate reaction - OUTERMOST (highest intensity) */}
            <div className="absolute inset-0 flex items-center justify-center">
              <div
                className={`${config.middle} rounded-full bg-gradient-to-br ${primary}/40 ${accent}/40 transition-all duration-50`}
                style={{
                  transform: `scale(${ringScales[0]})`,
                  opacity: isAudioPlaying ? 0.6 + (audioVolume / 100) * 0.4 : 0.3,
                  filter: `brightness(${1.0 + (audioVolume / 100) * 1.5}) saturate(${1.0 + (audioVolume / 100) * 1.2})`,
                }}
              />
            </div>
            
            {/* Ring 2 - delayed reaction */}
            <div className="absolute inset-0 flex items-center justify-center">
              <div
                className={`${config.middle} rounded-full bg-gradient-to-br ${primary}/35 ${accent}/35 transition-all duration-75`}
                style={{
                  transform: `scale(${ringScales[1]})`,
                  opacity: isAudioPlaying ? 0.5 + (audioVolume / 100) * 0.3 : 0.25,
                  filter: `brightness(${1.0 + (audioVolume / 100) * 1.3}) saturate(${1.0 + (audioVolume / 100) * 1.0})`,
                }}
              />
            </div>
            
            {/* Ring 3 - more delayed */}
            <div className="absolute inset-0 flex items-center justify-center">
              <div
                className={`${config.middle} rounded-full bg-gradient-to-br ${primary}/30 ${accent}/30 transition-all duration-100`}
                style={{
                  transform: `scale(${ringScales[2]})`,
                  opacity: isAudioPlaying ? 0.4 + (audioVolume / 100) * 0.2 : 0.2,
                  filter: `brightness(${1.0 + (audioVolume / 100) * 1.1}) saturate(${1.0 + (audioVolume / 100) * 0.8})`,
                }}
              />
            </div>
            
            {/* Ring 4 */}
            <div className="absolute inset-0 flex items-center justify-center">
              <div
                className={`${config.middle} rounded-full bg-gradient-to-br ${primary}/25 ${accent}/25 transition-all duration-125`}
                style={{
                  transform: `scale(${ringScales[3]})`,
                  opacity: isAudioPlaying ? 0.3 + (audioVolume / 100) * 0.15 : 0.15,
                  filter: `brightness(${1.0 + (audioVolume / 100) * 0.9}) saturate(${1.0 + (audioVolume / 100) * 0.6})`,
                }}
              />
            </div>
            
            {/* Ring 5 - INNERMOST (lowest intensity) */}
            <div className="absolute inset-0 flex items-center justify-center">
              <div
                className={`${config.middle} rounded-full bg-gradient-to-br ${primary}/20 ${accent}/20 transition-all duration-150`}
                style={{
                  transform: `scale(${ringScales[4]})`,
                  opacity: isAudioPlaying ? 0.2 + (audioVolume / 100) * 0.1 : 0.1,
                  filter: `brightness(${1.0 + (audioVolume / 100) * 0.7}) saturate(${1.0 + (audioVolume / 100) * 0.4})`,
                }}
              />
            </div>
          </>
        )}
        
        {/* Inner circle - full opacity, solid gradient - CENTER (minimal intensity) */}
        <div className="absolute inset-0 flex items-center justify-center">
          <div
            className={`${config.inner} rounded-full bg-gradient-to-br ${primary} ${accent} transition-all duration-50`}
            style={{
              transform: isAudioPlaying ? `scale(${1.0 + (audioVolume / 100) * 0.1})` : "scale(1.0)",
              filter: `brightness(${1.0 + (audioVolume / 100) * 0.5}) saturate(${1.0 + (audioVolume / 100) * 0.3})`,
            }}
          />
        </div>
        
        {/* Center text */}
        <div className="absolute inset-0 flex items-center justify-center">
          <p className={`text-white font-semibold ${config.text}`}>
            {displayText}
          </p>
        </div>
      </div>
    </div>
  );
};

export default AISpeakingAnimation;
