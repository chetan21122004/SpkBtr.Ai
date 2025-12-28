-- Add score columns to sessions table
-- Run this migration in your Supabase SQL editor

ALTER TABLE sessions
ADD COLUMN IF NOT EXISTS tone_score INTEGER CHECK (tone_score >= 0 AND tone_score <= 100),
ADD COLUMN IF NOT EXISTS confidence_score INTEGER CHECK (confidence_score >= 0 AND confidence_score <= 100),
ADD COLUMN IF NOT EXISTS fluency_score INTEGER CHECK (fluency_score >= 0 AND fluency_score <= 100),
ADD COLUMN IF NOT EXISTS user_audio_url TEXT;

-- Add comments for documentation
COMMENT ON COLUMN sessions.tone_score IS 'Tone score (0-100) calculated from audio analysis';
COMMENT ON COLUMN sessions.confidence_score IS 'Confidence score (0-100) calculated from audio analysis';
COMMENT ON COLUMN sessions.fluency_score IS 'Fluency score (0-100) calculated from audio analysis';
COMMENT ON COLUMN sessions.user_audio_url IS 'URL to user audio recording in Supabase Storage';

