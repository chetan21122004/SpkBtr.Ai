import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";

interface User {
  id: string;
  name: string;
  email: string;
  created_at: string;
}

const STORAGE_KEY = "voicecoach_user";

export const useAuth = () => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  // Load user from localStorage on mount
  useEffect(() => {
    const storedUser = localStorage.getItem(STORAGE_KEY);
    if (storedUser) {
      try {
        setUser(JSON.parse(storedUser));
      } catch (error) {
        console.error("Error parsing stored user:", error);
        localStorage.removeItem(STORAGE_KEY);
      }
    }
    setLoading(false);
  }, []);

  const register = async (email: string, password: string, name: string) => {
    try {
      // Check if user already exists
      const { data: existingUser, error: checkError } = await supabase
        .from("users")
        .select("email")
        .eq("email", email)
        .maybeSingle();

      if (checkError && checkError.code !== "PGRST116") {
        throw checkError;
      }

      if (existingUser) {
        throw new Error("User with this email already exists");
      }

      // Insert new user with plain text password
      const { data: newUser, error } = await supabase
        .from("users")
        .insert({
          email,
          password, // Plain text password (as requested)
          name,
        })
        .select()
        .single();

      if (error) throw error;

      if (newUser) {
        // Store user in state and localStorage
        const userData: User = {
          id: newUser.id,
          name: newUser.name,
          email: newUser.email,
          created_at: newUser.created_at,
        };
        setUser(userData);
        localStorage.setItem(STORAGE_KEY, JSON.stringify(userData));
        return { success: true, user: userData };
      }
    } catch (error: any) {
      console.error("Registration error:", error);
      return { success: false, error: error.message || "Registration failed" };
    }
  };

  const login = async (email: string, password: string) => {
    try {
      // Query user by email - use maybeSingle() to handle no results gracefully
      const { data: userData, error } = await supabase
        .from("users")
        .select("*")
        .eq("email", email)
        .maybeSingle();

      if (error) {
        throw error;
      }

      if (!userData) {
        throw new Error("Invalid email or password");
      }

      // Compare passwords (plain text comparison as requested)
      if (userData.password !== password) {
        throw new Error("Invalid email or password");
      }

      // Store user in state and localStorage
      const user: User = {
        id: userData.id,
        name: userData.name,
        email: userData.email,
        created_at: userData.created_at,
      };
      setUser(user);
      localStorage.setItem(STORAGE_KEY, JSON.stringify(user));
      return { success: true, user };
    } catch (error: any) {
      console.error("Login error:", error);
      return { success: false, error: error.message || "Login failed" };
    }
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem(STORAGE_KEY);
    // Redirect will be handled by AuthGuard
    window.location.href = "/login";
  };

  const getCurrentUser = (): User | null => {
    if (user) return user;
    const storedUser = localStorage.getItem(STORAGE_KEY);
    if (storedUser) {
      try {
        return JSON.parse(storedUser);
      } catch {
        return null;
      }
    }
    return null;
  };

  return {
    user,
    loading,
    register,
    login,
    logout,
    getCurrentUser,
    isAuthenticated: !!user,
  };
};

