import { useState, useEffect } from "react";
import { mockDb } from "@/mocks/mockDb";

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
      const newUser = await mockDb.registerUser(email, password, name);

      if (newUser) {
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
    } catch (error: unknown) {
      const message = error instanceof Error ? error.message : "Registration failed";
      console.error("Registration error:", error);
      return { success: false, error: message };
    }
  };

  const login = async (email: string, password: string) => {
    try {
      const userData = await mockDb.loginUser(email, password);
      if (!userData) {
        throw new Error("Invalid email or password");
      }

      const user: User = {
        id: userData.id,
        name: userData.name,
        email: userData.email,
        created_at: userData.created_at,
      };
      setUser(user);
      localStorage.setItem(STORAGE_KEY, JSON.stringify(user));
      return { success: true, user };
    } catch (error: unknown) {
      const message = error instanceof Error ? error.message : "Login failed";
      console.error("Login error:", error);
      return { success: false, error: message };
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

