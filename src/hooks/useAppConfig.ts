import { useState, useEffect } from "react";

interface AppConfig {
  elevenlabs_agent_id: string;
  elevenlabs_api_key: string;
  base_instructions: string;
}

export const useAppConfig = () => {
  const [config, setConfig] = useState<AppConfig | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    // Read configuration from environment variables
    const loadConfig = () => {
      try {
        const elevenlabs_api_key = import.meta.env.VITE_ELEVENLABS_API_KEY ;
        const elevenlabs_agent_id = import.meta.env.VITE_ELEVENLABS_AGENT_ID ;
        const base_instructions = import.meta.env.VITE_BASE_INSTRUCTIONS || "";

        // Validate required variables are present
        if (!elevenlabs_api_key || !elevenlabs_agent_id) {
          throw new Error(
            "Missing required configuration values. Please set VITE_ELEVENLABS_API_KEY and VITE_ELEVENLABS_AGENT_ID in your .env file"
          );
        }

        const configData: AppConfig = {
          elevenlabs_api_key,
          elevenlabs_agent_id,
          base_instructions,
        };

        setConfig(configData);
        setLoading(false);
      } catch (err) {
        setError(err as Error);
        setLoading(false);
      }
    };

    loadConfig();
  }, []);

  return { config, loading, error };
};

 