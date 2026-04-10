import { useRef, useState, useEffect } from "react";
import { useConversation } from "@elevenlabs/react";
import { useAppConfig } from "./useAppConfig";
import { analyzeAudioBlob } from "@/utils/audioAnalysis";
import { calculateAllScores, validateAnalysis } from "@/utils/scoreCalculation";
import { mockDb } from "@/mocks/mockDb";

interface UseVoiceConversationOptions {
  categoryName: string;
  userId?: string;
}

export const useVoiceConversation = ({ 
  categoryName,
  userId 
}: UseVoiceConversationOptions) => {
  const { config, loading: configLoading } = useAppConfig();
  const audioRef = useRef<HTMLAudioElement>(null);
  const [isListening, setIsListening] = useState(false);
  const [isConnected, setIsConnected] = useState(false);
  const [isAISpeaking, setIsAISpeaking] = useState(false);
  const [sessionId, setSessionId] = useState<string | null>(null);
  const [categoryId, setCategoryId] = useState<string | null>(null);
  const [categoryContext, setCategoryContext] = useState<string>("");
  const conversationRef = useRef<any>(null);
  const sessionIdRef = useRef<string | null>(null); // Ref to ensure callbacks have access to current sessionId
  const audioChunksRef = useRef<Blob[]>([]); // Store all audio chunks during session
  const messagesRef = useRef<Array<{ sender: 'user' | 'ai', text: string, timestamp: Date }>>([]); // Store all messages during session
  const aiSpeakingTimeoutRef = useRef<NodeJS.Timeout | null>(null);
  
  // User audio recording refs
  const userMediaStreamRef = useRef<MediaStream | null>(null);
  const mediaRecorderRef = useRef<MediaRecorder | null>(null);
  const userAudioChunksRef = useRef<Blob[]>([]);
  const recordingMimeTypeRef = useRef<string>("audio/webm");

  // Load category and context from mock DB
  useEffect(() => {
    // Reset state when category changes
    setCategoryId(null);
    setCategoryContext("");
    setSessionId(null);
    sessionIdRef.current = null; // Reset ref too
    audioChunksRef.current = []; // Clear audio chunks
    messagesRef.current = []; // Clear messages
    setIsConnected(false);
    setIsListening(false);
    setIsAISpeaking(false);
    
    // Clear AI speaking timeout if exists
    if (aiSpeakingTimeoutRef.current) {
      clearTimeout(aiSpeakingTimeoutRef.current);
      aiSpeakingTimeoutRef.current = null;
    }

    if (!categoryName) {
      return; // Don't load if categoryName is empty
    }

    const loadCategory = async () => {
      try {
        const category = await mockDb.getCategoryByName(categoryName);

        if (category) {
          setCategoryId(category.id);
          setCategoryContext(category.base_context);
        }
      } catch (error) {
        console.error("Error loading category:", error);
      }
    };

    loadCategory();
  }, [categoryName]);

  // Load previous messages for context
  const loadPreviousMessages = async (limit = 20) => {
    if (!userId || !categoryId) return "";

    try {
      const lastSession = await mockDb.getLatestSessionByUserAndCategory(userId, categoryId);

      if (!lastSession) return "";

      const allMessages = await mockDb.getMessagesBySession(lastSession.id);
      const messages = allMessages.slice(-limit);

      if (!messages || messages.length === 0) return "";

      // Format messages for context
      const contextMessages = messages
        .reverse()
        .map((msg) => `${msg.sender === "user" ? "User" : "AI"}: ${msg.text}`)
        .join("\n");

      return `\n\nPrevious conversation context:\n${contextMessages}`;
    } catch (error) {
      console.error("Error loading previous messages:", error);
      return "";
    }
  };

  // Helper function to keep an accessible URL for audio blobs
  const uploadAudioToStorage = async (blob: Blob, fileName: string, currentSessionId: string): Promise<string | null> => {
    try {
      if (!userId || !currentSessionId) {
        console.error("❌ Missing userId or sessionId for audio save", { userId, currentSessionId });
        return null;
      }
      const objectUrl = URL.createObjectURL(blob);
      console.log("✅ Mock audio saved:", { fileName, sessionId: currentSessionId, objectUrl });
      return objectUrl;
    } catch (error) {
      console.error("❌ Exception in uploadAudioToStorage:", error);
      if (error instanceof Error) {
        console.error("Error message:", error.message);
        console.error("Error stack:", error.stack);
      }
      return null;
    }
  };

  // Helper function to combine audio chunks into one file
  // Properly decodes and combines audio chunks to create a valid audio file
  const combineAudioChunks = async (chunks: Blob[]): Promise<{ blob: Blob, duration: number }> => {
    if (chunks.length === 0) {
      return { blob: new Blob([], { type: 'audio/wav' }), duration: 0 };
    }

    try {
      // Create audio context
      const audioContext = new (window.AudioContext || (window as any).webkitAudioContext)();
      
      // Decode all chunks to AudioBuffers
      const audioBuffers: AudioBuffer[] = [];
      let totalDuration = 0;
      
      for (const chunk of chunks) {
        try {
          const arrayBuffer = await chunk.arrayBuffer();
          const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);
          audioBuffers.push(audioBuffer);
          totalDuration += audioBuffer.duration;
        } catch (error) {
          console.warn("⚠️ Failed to decode audio chunk, skipping:", error);
        }
      }
      
      if (audioBuffers.length === 0) {
        await audioContext.close();
        return { blob: new Blob([], { type: 'audio/wav' }), duration: 0 };
      }
      
      // Get the sample rate from the first buffer (assume all have same rate)
      const sampleRate = audioBuffers[0].sampleRate;
      const numberOfChannels = audioBuffers[0].numberOfChannels;
      
      // Calculate total length
      const totalLength = audioBuffers.reduce((sum, buffer) => sum + buffer.length, 0);
      
      // Create a new AudioBuffer to hold all the data
      const combinedBuffer = audioContext.createBuffer(numberOfChannels, totalLength, sampleRate);
      
      // Copy all buffers into the combined buffer
      let offset = 0;
      for (const buffer of audioBuffers) {
        for (let channel = 0; channel < numberOfChannels; channel++) {
          const channelData = combinedBuffer.getChannelData(channel);
          const sourceData = buffer.getChannelData(channel);
          channelData.set(sourceData, offset);
        }
        offset += buffer.length;
      }
      
      // Convert AudioBuffer to WAV Blob (WAV is universally supported)
      const wavBlob = audioBufferToWAV(combinedBuffer);
      
      // Close audio context
      await audioContext.close();
      
      console.log("✅ Audio chunks combined:", {
        chunks: chunks.length,
        buffers: audioBuffers.length,
        duration: totalDuration,
        sampleRate,
        channels: numberOfChannels,
        outputSize: wavBlob.size
      });
      
      return { blob: wavBlob, duration: Math.round(totalDuration) };
    } catch (error) {
      console.error("❌ Error combining audio chunks:", error);
      // Fallback: try simple concatenation (may not work but better than nothing)
      const combinedBlob = new Blob(chunks, { type: 'audio/mpeg' });
      const estimatedDuration = Math.round((combinedBlob.size * 8) / 128000);
      return { blob: combinedBlob, duration: estimatedDuration };
    }
  };

  // Helper function to convert WebM to WAV for Supabase compatibility
  const convertWebMToWAV = async (webmBlob: Blob): Promise<Blob> => {
    try {
      // Create audio context
      const audioContext = new (window.AudioContext || (window as any).webkitAudioContext)();
      
      // Decode WebM audio
      const arrayBuffer = await webmBlob.arrayBuffer();
      const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);
      
      // Convert AudioBuffer to WAV
      const wavBlob = audioBufferToWAV(audioBuffer);
      
      // Close audio context
      await audioContext.close();
      
      return wavBlob;
    } catch (error) {
      console.error("❌ Error converting WebM to WAV:", error);
      throw error;
    }
  };

  // Helper function to convert AudioBuffer to WAV Blob
  const audioBufferToWAV = (buffer: AudioBuffer): Blob => {
    const numChannels = buffer.numberOfChannels;
    const sampleRate = buffer.sampleRate;
    const format = 1; // PCM
    const bitDepth = 16;
    
    const bytesPerSample = bitDepth / 8;
    const blockAlign = numChannels * bytesPerSample;
    
    const length = buffer.length * numChannels * bytesPerSample;
    const arrayBuffer = new ArrayBuffer(44 + length);
    const view = new DataView(arrayBuffer);
    
    // WAV header
    const writeString = (offset: number, string: string) => {
      for (let i = 0; i < string.length; i++) {
        view.setUint8(offset + i, string.charCodeAt(i));
      }
    };
    
    writeString(0, 'RIFF');
    view.setUint32(4, 36 + length, true);
    writeString(8, 'WAVE');
    writeString(12, 'fmt ');
    view.setUint32(16, 16, true); // fmt chunk size
    view.setUint16(20, format, true);
    view.setUint16(22, numChannels, true);
    view.setUint32(24, sampleRate, true);
    view.setUint32(28, sampleRate * blockAlign, true);
    view.setUint16(32, blockAlign, true);
    view.setUint16(34, bitDepth, true);
    writeString(36, 'data');
    view.setUint32(40, length, true);
    
    // Convert audio data
    let offset = 44;
    for (let i = 0; i < buffer.length; i++) {
      for (let channel = 0; channel < numChannels; channel++) {
        const sample = Math.max(-1, Math.min(1, buffer.getChannelData(channel)[i]));
        view.setInt16(offset, sample < 0 ? sample * 0x8000 : sample * 0x7FFF, true);
        offset += 2;
      }
    }
    
    return new Blob([arrayBuffer], { type: 'audio/wav' });
  };

  // Helper function to format messages as conversation
  const formatMessagesAsConversation = (messages: Array<{ sender: 'user' | 'ai', text: string }>): string => {
    if (messages.length === 0) {
      return "[No conversation recorded]";
    }

    return messages
      .map((msg) => `${msg.sender === 'user' ? 'User' : 'AI'}: ${msg.text}`)
      .join('\n\n');
  };

  // Start user audio recording
  const startUserAudioRecording = async (): Promise<boolean> => {
    try {
      // Check for MediaRecorder support
      if (typeof MediaRecorder === "undefined") {
        console.warn("⚠️ MediaRecorder not supported in this browser");
        return false;
      }

      // Request microphone access
      console.log("🎤 Requesting microphone access...");
      const stream = await navigator.mediaDevices.getUserMedia({
        audio: {
          echoCancellation: true,
          noiseSuppression: true,
          autoGainControl: true,
        },
      });

      userMediaStreamRef.current = stream;

      // Determine best MIME type (prioritize formats with better compatibility)
      let mimeType = "audio/webm";
      // Try WAV first for better iPhone/iOS compatibility
      if (MediaRecorder.isTypeSupported("audio/wav")) {
        mimeType = "audio/wav";
      } else if (MediaRecorder.isTypeSupported("audio/webm;codecs=opus")) {
        mimeType = "audio/webm;codecs=opus";
      } else if (MediaRecorder.isTypeSupported("audio/webm")) {
        mimeType = "audio/webm";
      } else if (MediaRecorder.isTypeSupported("audio/ogg;codecs=opus")) {
        mimeType = "audio/ogg;codecs=opus";
      } else if (MediaRecorder.isTypeSupported("audio/ogg")) {
        mimeType = "audio/ogg";
      } else if (MediaRecorder.isTypeSupported("audio/mp4")) {
        mimeType = "audio/mp4";
      }
      recordingMimeTypeRef.current = mimeType;

      console.log("📹 Using MIME type:", mimeType);

      // Create MediaRecorder
      const recorder = new MediaRecorder(stream, { mimeType });
      mediaRecorderRef.current = recorder;

      // Clear previous chunks
      userAudioChunksRef.current = [];

      // Set up data handler
      recorder.ondataavailable = (event) => {
        if (event.data && event.data.size > 0) {
          userAudioChunksRef.current.push(event.data);
          console.log("📦 User audio chunk recorded:", event.data.size, "bytes");
        }
      };

      // Set up error handler
      recorder.onerror = (event) => {
        console.error("❌ MediaRecorder error:", event);
      };

      // Start recording (collect chunks every second)
      recorder.start(1000);
      console.log("✅ User audio recording started");

      return true;
    } catch (error) {
      console.error("❌ Error starting user audio recording:", error);
      if (error instanceof Error) {
        if (error.name === "NotAllowedError" || error.name === "PermissionDeniedError") {
          console.warn("⚠️ Microphone permission denied - continuing without user audio recording");
        } else if (error.name === "NotFoundError" || error.name === "DevicesNotFoundError") {
          console.warn("⚠️ No microphone found - continuing without user audio recording");
        }
      }
      return false;
    }
  };

  // Stop user audio recording and return blob
  const stopUserAudioRecording = async (): Promise<{ blob: Blob | null; duration: number }> => {
    try {
      const recorder = mediaRecorderRef.current;
      const stream = userMediaStreamRef.current;

      if (!recorder || recorder.state === "inactive") {
        console.warn("⚠️ No active recording to stop");
        return { blob: null, duration: 0 };
      }

      // Wait for final chunk
      const recordingStopped = new Promise<void>((resolve) => {
        recorder.onstop = () => {
          console.log("🛑 User audio recording stopped");
          resolve();
        };
      });

      // Stop recording
      recorder.stop();

      // Wait for stop event
      await recordingStopped;

      // Stop all tracks
      if (stream) {
        stream.getTracks().forEach((track) => {
          track.stop();
          console.log("🛑 Stopped media track:", track.kind);
        });
        userMediaStreamRef.current = null;
      }

      // Combine chunks into single blob
      if (userAudioChunksRef.current.length === 0) {
        console.warn("⚠️ No audio chunks recorded");
        return { blob: null, duration: 0 };
      }

      const audioBlob = new Blob(userAudioChunksRef.current, {
        type: recordingMimeTypeRef.current,
      });

      console.log("✅ User audio blob created:", {
        size: audioBlob.size,
        type: audioBlob.type,
        chunks: userAudioChunksRef.current.length,
      });

      // Calculate duration with proper metadata loading
      // Fix for duration not showing in audio players
      const duration = await new Promise<number>((resolve) => {
        const audio = new Audio();
        const url = URL.createObjectURL(audioBlob);
        audio.src = url;
        
        // Set initial currentTime to force metadata loading (fixes duration issue)
        audio.currentTime = Number.MAX_SAFE_INTEGER;

        const handleLoadedMetadata = () => {
          // Reset currentTime after metadata loads
          audio.currentTime = 0;
          const durationInSeconds = audio.duration && isFinite(audio.duration) 
            ? Math.round(audio.duration) 
            : 0;
          URL.revokeObjectURL(url);
          audio.removeEventListener("loadedmetadata", handleLoadedMetadata);
          audio.removeEventListener("error", handleError);
          resolve(durationInSeconds);
        };

        const handleError = () => {
          URL.revokeObjectURL(url);
          audio.removeEventListener("loadedmetadata", handleLoadedMetadata);
          audio.removeEventListener("error", handleError);
          // Fallback: estimate based on blob size
          // WebM: ~64kbps, WAV: ~1411kbps, OGG: ~64kbps
          const bitrate = audioBlob.type.includes('wav') ? 1411000 : 64000;
          const estimatedDuration = Math.round((audioBlob.size * 8) / bitrate);
          resolve(estimatedDuration || 0);
        };

        audio.addEventListener("loadedmetadata", handleLoadedMetadata);
        audio.addEventListener("error", handleError);
        
        // Force load to trigger metadata loading
        audio.load();
        
        // Timeout fallback (in case metadata never loads)
        setTimeout(() => {
          if (audio.readyState >= 2) { // HAVE_CURRENT_DATA or higher
            const durationInSeconds = audio.duration && isFinite(audio.duration) 
              ? Math.round(audio.duration) 
              : 0;
            if (durationInSeconds > 0) {
              URL.revokeObjectURL(url);
              audio.removeEventListener("loadedmetadata", handleLoadedMetadata);
              audio.removeEventListener("error", handleError);
              resolve(durationInSeconds);
            }
          }
        }, 2000);
      });

      // Clear chunks
      userAudioChunksRef.current = [];
      mediaRecorderRef.current = null;

      return { blob: audioBlob, duration };
    } catch (error) {
      console.error("❌ Error stopping user audio recording:", error);
      return { blob: null, duration: 0 };
    }
  };

  const conversation = useConversation({
    onConnect: () => {
      setIsConnected(true);
    },
    onDisconnect: () => {
      setIsConnected(false);
    },
    onStatusChange: ({ status }) => {
      setIsConnected(status === "connected" || status === "connecting");
    },
    onAudio: async (base64Audio: string) => {
      // Set AI speaking to true when audio chunk arrives
      setIsAISpeaking(true);
      
      // Clear any existing timeout
      if (aiSpeakingTimeoutRef.current) {
        clearTimeout(aiSpeakingTimeoutRef.current);
      }
      
      // Set timeout to hide indicator after 3 seconds (estimate: audio chunks are ~1-2 seconds each)
      aiSpeakingTimeoutRef.current = setTimeout(() => {
        setIsAISpeaking(false);
      }, 3000);
      
      if (audioRef.current) {
        const byteCharacters = atob(base64Audio);
        const byteNumbers = new Array(byteCharacters.length);
        for (let i = 0; i < byteCharacters.length; i++) {
          byteNumbers[i] = byteCharacters.charCodeAt(i);
        }
        const byteArray = new Uint8Array(byteNumbers);
        const blob = new Blob([byteArray], { type: "audio/mpeg" });
        const url = URL.createObjectURL(blob);
        audioRef.current.src = url;
        audioRef.current.play().catch(() => {});

        // Store audio chunk in memory (don't save yet)
        audioChunksRef.current.push(blob);
        console.log("📦 Audio chunk stored in memory (total chunks:", audioChunksRef.current.length + ")");
      }
    },
    // Check for transcript callbacks (may not be available in all SDK versions)
    onUserTranscript: async (transcript: string) => {
      // Store user transcript in memory (don't save yet)
      if (transcript) {
        messagesRef.current.push({
          sender: 'user',
          text: transcript,
          timestamp: new Date()
        });
        console.log("📝 User transcript stored in memory:", transcript.substring(0, 50));
      }
    },
    onAgentTranscript: async (transcript: string) => {
      // Set AI speaking to true when transcript arrives
      setIsAISpeaking(true);
      
      // Clear any existing timeout
      if (aiSpeakingTimeoutRef.current) {
        clearTimeout(aiSpeakingTimeoutRef.current);
      }
      
      // Set timeout to hide after 1 second (transcript indicates AI finished speaking)
      aiSpeakingTimeoutRef.current = setTimeout(() => {
        setIsAISpeaking(false);
      }, 1000);
      
      // Store AI transcript in memory (don't save yet)
      if (transcript) {
        messagesRef.current.push({
          sender: 'ai',
          text: transcript,
          timestamp: new Date()
        });
        console.log("📝 AI transcript stored in memory:", transcript.substring(0, 50));
      }
    },
    apiKey: config?.elevenlabs_api_key || "",
  });

  // Store conversation in ref for cleanup
  useEffect(() => {
    conversationRef.current = conversation;
  }, [conversation]);

  // Keep sessionIdRef in sync with sessionId state
  useEffect(() => {
    sessionIdRef.current = sessionId;
  }, [sessionId]);

  // Cleanup: Stop session when category changes
  useEffect(() => {
    return () => {
      if (isListening && conversationRef.current) {
        conversationRef.current.endSession().catch(() => {});
      }
    };
  }, [categoryName, isListening]);

  const startSession = async () => {
    try {
      // Wait for config to load first
      if (configLoading || !config) {
        console.error("❌ Config not loaded yet");
        return;
      }

      // Ensure we have userId and categoryId
      if (!userId || !categoryId) {
        console.error("❌ Missing userId or categoryId", { userId, categoryId, categoryName });
        return;
      }

      console.log("📝 Creating session in mock store...", { userId, categoryId });
      const session = await mockDb.createSession({
        user_id: userId,
        category_id: categoryId,
        started_at: new Date().toISOString(),
      });
      if (!session || !session.id) {
        console.error("❌ Session creation returned no data");
        return;
      }

      const newSessionId = session.id;
      console.log("✅ Session created:", newSessionId);
      
      // Set sessionId in both state and ref immediately
      setSessionId(newSessionId);
      sessionIdRef.current = newSessionId;
      
      // Initialize memory storage for this session
      audioChunksRef.current = [];
      messagesRef.current = [];
      console.log("📦 Memory storage initialized for session");

      // Start user audio recording
      try {
        const recordingStarted = await startUserAudioRecording();
        if (!recordingStarted) {
          console.warn("⚠️ User audio recording not started, but continuing with session");
        }
      } catch (error) {
        console.error("❌ Error starting user audio recording:", error);
        // Don't block session if recording fails
      }

      // Load previous context
      const previousContext = await loadPreviousMessages();
      
      // Build full persona context with base instructions + category persona + previous messages
      const baseInstructions = config.base_instructions || "";
      const fullContext = `${baseInstructions}\n\n${categoryContext}${previousContext}`;

      // Start 11Labs session with the single agent
      console.log("🎙️ Starting 11Labs session...");
      await conversation.startSession({
        agentId: config.elevenlabs_agent_id,
        connectionType: "webrtc",
      });

      // Log the persona context for debugging
      console.log("✅ Session started successfully");
      console.log("📋 Category:", categoryName);
      console.log("💬 Context preview:", categoryContext.substring(0, 200) + "...");

      setIsListening(true);
    } catch (err) {
      console.error("❌ startSession error", err);
    }
  };

  const stopSession = async () => {
    try {
      const currentSessionId = sessionIdRef.current;
      
      await conversation.endSession();

      if (!currentSessionId) {
        console.warn("⚠️ No sessionId available when ending session");
        setIsListening(false);
        return;
      }

      console.log("💾 Saving session data...");
      console.log("📦 Audio chunks:", audioChunksRef.current.length);
      console.log("📝 Messages:", messagesRef.current.length);

      // 0. Stop user audio recording and analyze
      let userAudioUrl: string | null = null;
      let toneScore: number | null = null;
      let confidenceScore: number | null = null;
      let fluencyScore: number | null = null;

      try {
        const { blob: userAudioBlob, duration: userAudioDuration } = await stopUserAudioRecording();
        
        if (userAudioBlob && userAudioBlob.size > 0) {
          console.log("🎤 User audio recorded:", {
            size: userAudioBlob.size,
            duration: userAudioDuration,
            type: userAudioBlob.type,
          });

          // Upload user audio to storage
          // Convert WebM to WAV if needed (Supabase doesn't support WebM)
          try {
            let audioBlobToUpload = userAudioBlob;
            const fileExtension = userAudioBlob.type.includes('ogg') ? 'ogg' : 
                                  userAudioBlob.type.includes('webm') ? 'wav' : 'mp3';
            
            // Convert WebM to WAV for Supabase compatibility
            if (userAudioBlob.type.includes('webm')) {
              console.log("🔄 Converting WebM to WAV for Supabase upload...");
              audioBlobToUpload = await convertWebMToWAV(userAudioBlob);
              console.log("✅ Conversion complete:", {
                originalSize: userAudioBlob.size,
                convertedSize: audioBlobToUpload.size,
                originalType: userAudioBlob.type,
                convertedType: audioBlobToUpload.type
              });
            }
            
            const userFileName = `user-session-${currentSessionId}.${fileExtension}`;
            userAudioUrl = await uploadAudioToStorage(audioBlobToUpload, userFileName, currentSessionId);
            if (userAudioUrl) {
              console.log("✅ User audio uploaded:", userAudioUrl);
            }
          } catch (uploadError) {
            console.warn("⚠️ Failed to upload user audio, continuing without URL:", uploadError);
          }

          // Analyze user audio
          try {
            console.log("🔍 Analyzing user audio...");
            const analysis = await analyzeAudioBlob(userAudioBlob);
            
            if (validateAnalysis(analysis)) {
              const scores = calculateAllScores(analysis);
              toneScore = scores.toneScore;
              confidenceScore = scores.confidenceScore;
              fluencyScore = scores.fluencyScore;
              
              console.log("📊 Analysis complete:", {
                tone: toneScore,
                confidence: confidenceScore,
                fluency: fluencyScore,
                metrics: analysis.metrics,
              });
            } else {
              console.warn("⚠️ Audio analysis validation failed, skipping score calculation");
            }
          } catch (analysisError) {
            console.error("❌ Error analyzing user audio:", analysisError);
            // Continue without scores
          }
        } else {
          console.log("ℹ️ No user audio recorded (recording may not have started)");
        }
      } catch (recordingError) {
        console.error("❌ Error stopping user audio recording:", recordingError);
        // Continue without user audio
      }

      // 1. Combine all audio chunks into one file
      const { blob: combinedAudio, duration } = await combineAudioChunks(audioChunksRef.current);
      console.log("🔊 Combined audio duration:", duration, "seconds");

      // 2. Format all messages into one conversation string
      const conversationText = formatMessagesAsConversation(messagesRef.current);
      console.log("💬 Conversation length:", conversationText.length, "characters");

      // 3. Upload combined audio to Supabase Storage
      let audioUrl: string | null = null;
      if (combinedAudio.size > 0) {
        const fileName = `session-${currentSessionId}.wav`;
        console.log("💾 [Upload] Starting upload process...");
        console.log("💾 [Upload] File details:", {
          fileName,
          size: combinedAudio.size,
          type: combinedAudio.type,
          sessionId: currentSessionId
        });
        
        audioUrl = await uploadAudioToStorage(combinedAudio, fileName, currentSessionId);
        
        if (audioUrl) {
          console.log("✅ [Upload] Combined audio uploaded successfully:", audioUrl);
        } else {
          console.error("❌ [Upload] Failed to upload combined audio - check logs above for details");
        }
      } else {
        console.warn("⚠️ [Upload] No audio chunks to upload (combinedAudio.size is 0)");
      }

      // 4. Save one message entry with formatted conversation text
      // Always save a message, even if no transcripts were captured
      const messageText = conversationText !== "[No conversation recorded]" 
        ? conversationText 
        : "[Audio session recorded - transcripts not available]";

      await mockDb.addMessage({
        session_id: currentSessionId,
        sender: "ai", // Using 'ai' as default since it's a combined conversation
        text: messageText,
        audio_url: audioUrl,
      });
      console.log("✅ Conversation message saved");

      // 5. Save one recording entry with combined audio URL
      if (audioUrl && userId) {
        await mockDb.addRecording({
          user_id: userId,
          session_id: currentSessionId,
          audio_url: audioUrl,
          duration: duration,
        });
        console.log("✅ Recording saved:", audioUrl, `(${duration}s)`);
      }

      // 6. Save scores to database
      if (toneScore !== null || confidenceScore !== null || fluencyScore !== null) {
        try {
          const updateData: {
            ended_at: string;
            tone_score?: number;
            confidence_score?: number;
            fluency_score?: number;
            user_audio_url?: string | null;
          } = {
            ended_at: new Date().toISOString(),
          };

          if (toneScore !== null) updateData.tone_score = toneScore;
          if (confidenceScore !== null) updateData.confidence_score = confidenceScore;
          if (fluencyScore !== null) updateData.fluency_score = fluencyScore;
          if (userAudioUrl) updateData.user_audio_url = userAudioUrl;
          await mockDb.updateSession(currentSessionId, updateData);
          console.log("✅ Scores saved to mock store:", {
            tone: toneScore,
            confidence: confidenceScore,
            fluency: fluencyScore,
          });
        } catch (scoreSaveError) {
          console.error("❌ Error saving scores:", scoreSaveError);
          await mockDb.updateSession(currentSessionId, { ended_at: new Date().toISOString() });
          console.log("✅ Session ended (scores not saved):", currentSessionId);
        }
      } else {
        await mockDb.updateSession(currentSessionId, { ended_at: new Date().toISOString() });
        console.log("✅ Session ended:", currentSessionId);
      }

      // 7. Clear memory refs
      audioChunksRef.current = [];
      messagesRef.current = [];
      console.log("🧹 Memory storage cleared");
      
      // Clear AI speaking timeout and reset state
      if (aiSpeakingTimeoutRef.current) {
        clearTimeout(aiSpeakingTimeoutRef.current);
        aiSpeakingTimeoutRef.current = null;
      }
      setIsAISpeaking(false);
    } catch (err) {
      console.error("❌ endSession error", err);
    } finally {
      setIsListening(false);
    }
  };

  const saveUserMessage = async (text: string, audioBlob?: Blob) => {
    // Store user message and audio in memory (will be saved when session ends)
    if (text) {
      messagesRef.current.push({
        sender: 'user',
        text: text,
        timestamp: new Date()
      });
    }

    if (audioBlob) {
      audioChunksRef.current.push(audioBlob);
    }

    console.log("📦 User message stored in memory (will be saved when session ends)");
  };

  return {
    audioRef,
    isListening,
    isConnected,
    isAISpeaking,
    sessionId,
    categoryContext,
    startSession,
    stopSession,
    saveUserMessage,
  };
};
