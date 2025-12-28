/**
 * Audio Analysis Utilities
 * Uses Web Audio API to extract metrics from audio recordings
 */

export interface AudioAnalysis {
  pitchData: number[];
  volumeData: number[];
  pauses: Array<{ start: number; end: number }>;
  metrics: {
    pitchVariation: number;
    frequencyStability: number;
    volumeConsistency: number;
    pauseFrequency: number; // pauses per minute
    averagePauseLength: number; // seconds
    silenceRatio: number; // 0-1
    speakingContinuity: number; // 0-1
    duration: number; // seconds
  };
}

/**
 * Main function to analyze audio blob and extract metrics
 */
export async function analyzeAudioBlob(blob: Blob): Promise<AudioAnalysis> {
  try {
    // Create audio context
    const audioContext = new (window.AudioContext || (window as any).webkitAudioContext)();
    
    // Decode audio data
    const arrayBuffer = await blob.arrayBuffer();
    const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);
    
    // Extract data
    const pitchData = extractPitchData(audioBuffer);
    const volumeData = extractVolumeData(audioBuffer);
    const pauses = detectPauses(audioBuffer, 0.01); // 1% threshold for silence
    
    // Calculate metrics
    const pitchVariation = calculatePitchVariation(pitchData);
    const frequencyStability = calculateFrequencyStability(pitchData);
    const volumeConsistency = calculateVolumeConsistency(volumeData);
    const pauseMetrics = calculatePauseMetrics(pauses, audioBuffer.duration);
    const silenceRatio = calculateSilenceRatio(audioBuffer, pauses);
    const speakingContinuity = analyzeSpeakingContinuity(audioBuffer, pauses);
    
    // Close audio context
    await audioContext.close();
    
    return {
      pitchData,
      volumeData,
      pauses,
      metrics: {
        pitchVariation,
        frequencyStability,
        volumeConsistency,
        pauseFrequency: pauseMetrics.frequency,
        averagePauseLength: pauseMetrics.averageLength,
        silenceRatio,
        speakingContinuity,
        duration: audioBuffer.duration,
      },
    };
  } catch (error) {
    console.error("Error analyzing audio:", error);
    throw error;
  }
}

/**
 * Extract pitch/frequency data from audio buffer
 * Uses autocorrelation method for pitch detection
 */
function extractPitchData(audioBuffer: AudioBuffer): number[] {
  const channelData = audioBuffer.getChannelData(0); // Use first channel
  const sampleRate = audioBuffer.sampleRate;
  const frameSize = 2048; // Analysis window size
  const hopSize = 512; // Step size
  const pitchData: number[] = [];
  
  for (let i = 0; i < channelData.length - frameSize; i += hopSize) {
    const frame = channelData.slice(i, i + frameSize);
    const pitch = detectPitchInFrame(frame, sampleRate);
    if (pitch > 0) {
      pitchData.push(pitch);
    }
  }
  
  return pitchData;
}

/**
 * Detect pitch in a frame using autocorrelation
 */
function detectPitchInFrame(frame: Float32Array, sampleRate: number): number {
  // Simple autocorrelation for pitch detection
  const minPeriod = Math.floor(sampleRate / 800); // ~800 Hz max
  const maxPeriod = Math.floor(sampleRate / 80); // ~80 Hz min
  
  let maxCorrelation = 0;
  let bestPeriod = 0;
  
  for (let period = minPeriod; period < maxPeriod && period < frame.length / 2; period++) {
    let correlation = 0;
    for (let i = 0; i < frame.length - period; i++) {
      correlation += frame[i] * frame[i + period];
    }
    
    if (correlation > maxCorrelation) {
      maxCorrelation = correlation;
      bestPeriod = period;
    }
  }
  
  if (bestPeriod > 0 && maxCorrelation > 0.1) {
    return sampleRate / bestPeriod; // Convert to frequency (Hz)
  }
  
  return 0;
}

/**
 * Calculate pitch variation (standard deviation normalized)
 */
export function calculatePitchVariation(pitchData: number[]): number {
  if (pitchData.length === 0) return 0;
  
  const mean = pitchData.reduce((sum, p) => sum + p, 0) / pitchData.length;
  const variance = pitchData.reduce((sum, p) => sum + Math.pow(p - mean, 2), 0) / pitchData.length;
  const stdDev = Math.sqrt(variance);
  
  // Normalize: variation is good (0.1-0.3 is ideal), too much (0.5+) is bad
  // Convert to 0-1 scale where 0.2 is optimal (score = 1)
  const normalized = Math.max(0, 1 - Math.abs(stdDev / mean - 0.2) / 0.3);
  return Math.min(1, normalized);
}

/**
 * Calculate frequency stability (inverse of variation)
 */
export function calculateFrequencyStability(pitchData: number[]): number {
  if (pitchData.length === 0) return 0;
  
  const mean = pitchData.reduce((sum, p) => sum + p, 0) / pitchData.length;
  const variance = pitchData.reduce((sum, p) => sum + Math.pow(p - mean, 2), 0) / pitchData.length;
  const stdDev = Math.sqrt(variance);
  const coefficientOfVariation = stdDev / mean;
  
  // Lower CV = more stable (better)
  // Normalize: CV < 0.1 is very stable (score = 1), CV > 0.3 is unstable (score = 0)
  const normalized = Math.max(0, 1 - (coefficientOfVariation - 0.1) / 0.2);
  return Math.min(1, normalized);
}

/**
 * Extract volume/RMS data from audio buffer
 */
function extractVolumeData(audioBuffer: AudioBuffer): number[] {
  const channelData = audioBuffer.getChannelData(0);
  const frameSize = 1024; // Analysis window
  const volumeData: number[] = [];
  
  for (let i = 0; i < channelData.length; i += frameSize) {
    const frame = channelData.slice(i, i + frameSize);
    const rms = calculateRMS(frame);
    volumeData.push(rms);
  }
  
  return volumeData;
}

/**
 * Calculate RMS (Root Mean Square) for volume
 */
function calculateRMS(frame: Float32Array): number {
  let sum = 0;
  for (let i = 0; i < frame.length; i++) {
    sum += frame[i] * frame[i];
  }
  return Math.sqrt(sum / frame.length);
}

/**
 * Calculate volume consistency (coefficient of variation)
 */
export function calculateVolumeConsistency(volumeData: number[]): number {
  if (volumeData.length === 0) return 0;
  
  const mean = volumeData.reduce((sum, v) => sum + v, 0) / volumeData.length;
  if (mean === 0) return 0;
  
  const variance = volumeData.reduce((sum, v) => sum + Math.pow(v - mean, 2), 0) / volumeData.length;
  const stdDev = Math.sqrt(variance);
  const coefficientOfVariation = stdDev / mean;
  
  // Lower CV = more consistent (better)
  // Normalize: CV < 0.2 is consistent (score = 1), CV > 0.6 is inconsistent (score = 0)
  const normalized = Math.max(0, 1 - (coefficientOfVariation - 0.2) / 0.4);
  return Math.min(1, normalized);
}

/**
 * Detect pauses/silence in audio
 */
function detectPauses(audioBuffer: AudioBuffer, threshold: number): Array<{ start: number; end: number }> {
  const channelData = audioBuffer.getChannelData(0);
  const sampleRate = audioBuffer.sampleRate;
  const frameSize = 1024;
  const minPauseDuration = 0.2; // Minimum 200ms to count as pause
  const pauses: Array<{ start: number; end: number }> = [];
  
  let inPause = false;
  let pauseStart = 0;
  
  for (let i = 0; i < channelData.length; i += frameSize) {
    const frame = channelData.slice(i, i + frameSize);
    const rms = calculateRMS(frame);
    const time = i / sampleRate;
    
    if (rms < threshold) {
      if (!inPause) {
        pauseStart = time;
        inPause = true;
      }
    } else {
      if (inPause) {
        const pauseDuration = time - pauseStart;
        if (pauseDuration >= minPauseDuration) {
          pauses.push({ start: pauseStart, end: time });
        }
        inPause = false;
      }
    }
  }
  
  // Handle pause at end
  if (inPause) {
    const pauseDuration = audioBuffer.duration - pauseStart;
    if (pauseDuration >= minPauseDuration) {
      pauses.push({ start: pauseStart, end: audioBuffer.duration });
    }
  }
  
  return pauses;
}

/**
 * Calculate pause metrics
 */
function calculatePauseMetrics(
  pauses: Array<{ start: number; end: number }>,
  totalDuration: number
): { frequency: number; averageLength: number } {
  if (pauses.length === 0) {
    return { frequency: 0, averageLength: 0 };
  }
  
  const totalPauseTime = pauses.reduce((sum, p) => sum + (p.end - p.start), 0);
  const averageLength = totalPauseTime / pauses.length;
  const frequency = (pauses.length / totalDuration) * 60; // pauses per minute
  
  return { frequency, averageLength };
}

/**
 * Calculate silence ratio (0-1)
 */
function calculateSilenceRatio(
  audioBuffer: AudioBuffer,
  pauses: Array<{ start: number; end: number }>
): number {
  if (pauses.length === 0) return 0;
  
  const totalPauseTime = pauses.reduce((sum, p) => sum + (p.end - p.start), 0);
  return totalPauseTime / audioBuffer.duration;
}

/**
 * Analyze speaking continuity
 * Measures how smoothly speech flows (fewer long pauses = better)
 */
function analyzeSpeakingContinuity(
  audioBuffer: AudioBuffer,
  pauses: Array<{ start: number; end: number }>
): number {
  if (pauses.length === 0) return 1;
  
  // Calculate average gap between pauses (speech segments)
  const speechSegments: number[] = [];
  let lastEnd = 0;
  
  for (const pause of pauses) {
    if (pause.start > lastEnd) {
      speechSegments.push(pause.start - lastEnd);
    }
    lastEnd = pause.end;
  }
  
  // Add final segment
  if (lastEnd < audioBuffer.duration) {
    speechSegments.push(audioBuffer.duration - lastEnd);
  }
  
  if (speechSegments.length === 0) return 0;
  
  const avgSegmentLength = speechSegments.reduce((sum, s) => sum + s, 0) / speechSegments.length;
  const avgPauseLength = pauses.reduce((sum, p) => sum + (p.end - p.start), 0) / pauses.length;
  
  // Better continuity = longer segments, shorter pauses
  // Normalize: longer segments relative to pauses = better
  const ratio = avgSegmentLength / (avgSegmentLength + avgPauseLength);
  return Math.min(1, ratio);
}

