/**
 * Score Calculation Utilities
 * Converts audio analysis metrics to 0-100 scores for tone, confidence, and fluency
 */

import { AudioAnalysis } from "./audioAnalysis";

export interface ScoreResults {
  toneScore: number; // 0-100
  confidenceScore: number; // 0-100
  fluencyScore: number; // 0-100
}

/**
 * Calculate tone score from audio analysis
 * Based on pitch variation and frequency stability
 */
export function calculateToneScore(analysis: AudioAnalysis): number {
  try {
    const { pitchVariation, frequencyStability } = analysis.metrics;
    
    // Formula: (pitchVariation * 0.4 + frequencyStability * 0.6) * 100
    // Pitch variation: Some variation is good (shows expressiveness)
    // Frequency stability: Consistency is good (shows control)
    const score = (pitchVariation * 0.4 + frequencyStability * 0.6) * 100;
    
    // Ensure score is within 0-100 range
    return Math.max(0, Math.min(100, Math.round(score)));
  } catch (error) {
    console.error("Error calculating tone score:", error);
    return 0;
  }
}

/**
 * Calculate confidence score from audio analysis
 * Based on volume consistency and pause frequency
 */
export function calculateConfidenceScore(analysis: AudioAnalysis): number {
  try {
    const { volumeConsistency, pauseFrequency } = analysis.metrics;
    
    // Calculate pause score: fewer pauses = more confident
    // Normalize pause frequency: 0-10 pauses/min is good (score = 1), 20+ is bad (score = 0)
    const pauseScore = Math.max(0, 1 - (pauseFrequency / 10));
    
    // Formula: (volumeConsistency * 0.5 + pauseScore * 0.5) * 100
    const score = (volumeConsistency * 0.5 + pauseScore * 0.5) * 100;
    
    // Ensure score is within 0-100 range
    return Math.max(0, Math.min(100, Math.round(score)));
  } catch (error) {
    console.error("Error calculating confidence score:", error);
    return 0;
  }
}

/**
 * Calculate fluency score from audio analysis
 * Based on pause frequency, silence ratio, and speaking continuity
 */
export function calculateFluencyScore(analysis: AudioAnalysis): number {
  try {
    const { pauseFrequency, silenceRatio, speakingContinuity } = analysis.metrics;
    
    // Calculate pause score: fewer pauses = more fluent
    const pauseScore = Math.max(0, 1 - (pauseFrequency / 10));
    
    // Silence ratio: less silence = more fluent
    const silenceScore = 1 - silenceRatio;
    
    // Formula: (pauseScore * 0.4 + silenceScore * 0.3 + speakingContinuity * 0.3) * 100
    const score = (pauseScore * 0.4 + silenceScore * 0.3 + speakingContinuity * 0.3) * 100;
    
    // Ensure score is within 0-100 range
    return Math.max(0, Math.min(100, Math.round(score)));
  } catch (error) {
    console.error("Error calculating fluency score:", error);
    return 0;
  }
}

/**
 * Calculate all scores from audio analysis
 */
export function calculateAllScores(analysis: AudioAnalysis): ScoreResults {
  return {
    toneScore: calculateToneScore(analysis),
    confidenceScore: calculateConfidenceScore(analysis),
    fluencyScore: calculateFluencyScore(analysis),
  };
}

/**
 * Validate audio analysis before calculating scores
 */
export function validateAnalysis(analysis: AudioAnalysis): boolean {
  if (!analysis || !analysis.metrics) {
    return false;
  }
  
  const { duration } = analysis.metrics;
  
  // Require minimum duration for meaningful analysis
  if (duration < 1) {
    console.warn("Audio too short for analysis:", duration);
    return false;
  }
  
  // Check if we have enough data
  if (analysis.pitchData.length === 0 && analysis.volumeData.length === 0) {
    console.warn("No audio data extracted");
    return false;
  }
  
  return true;
}

