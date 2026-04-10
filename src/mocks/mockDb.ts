import * as LucideIcons from "lucide-react";
import type { Category } from "@/hooks/useCategories";
import {
  seedCategories,
  seedMessages,
  seedRecordings,
  seedSessions,
  seedUsers,
  type MockMessage,
  type MockRecording,
  type MockSession,
  type MockUser,
} from "./mockData";

const iconMap: Record<string, LucideIcons.LucideIcon> = {
  Mic: LucideIcons.Mic,
  Briefcase: LucideIcons.Briefcase,
  Users: LucideIcons.Users,
  MessageCircle: LucideIcons.MessageCircle,
  Volume2: LucideIcons.Volume2,
  Heart: LucideIcons.Heart,
  Brain: LucideIcons.Brain,
  Presentation: LucideIcons.Presentation,
  Phone: LucideIcons.Phone,
};

const categories: Category[] = seedCategories.map((cat) => ({
  ...cat,
  icon: cat.icon_name ? iconMap[cat.icon_name] : undefined,
}));
let users: MockUser[] = [...seedUsers];
let sessions: MockSession[] = [...seedSessions];
let messages: MockMessage[] = [...seedMessages];
let recordings: MockRecording[] = [...seedRecordings];

const delay = async () => {
  await Promise.resolve();
};

const id = (prefix: string) => `${prefix}-${Math.random().toString(36).slice(2, 10)}`;

export const mockDb = {
  async getCategories(): Promise<Category[]> {
    await delay();
    return categories.filter((c) => c.is_active).sort((a, b) => a.display_order - b.display_order);
  },

  async getCategoryByName(name: string): Promise<Category | null> {
    await delay();
    return categories.find((c) => c.name === name) ?? null;
  },

  async findUserByEmail(email: string): Promise<MockUser | null> {
    await delay();
    return users.find((u) => u.email.toLowerCase() === email.toLowerCase()) ?? null;
  },

  async registerUser(email: string, password: string, name: string): Promise<MockUser> {
    await delay();
    const existing = users.find((u) => u.email.toLowerCase() === email.toLowerCase());
    if (existing) {
      throw new Error("User with this email already exists");
    }
    const created: MockUser = {
      id: id("user"),
      email,
      password,
      name,
      created_at: new Date().toISOString(),
    };
    users = [created, ...users];
    return created;
  },

  async loginUser(email: string, password: string): Promise<MockUser> {
    await delay();
    const user = users.find((u) => u.email.toLowerCase() === email.toLowerCase());
    if (!user || user.password !== password) {
      throw new Error("Invalid email or password");
    }
    return user;
  },

  async createSession(input: { user_id: string; category_id: string; started_at: string }): Promise<MockSession> {
    await delay();
    const created: MockSession = {
      id: id("sess"),
      user_id: input.user_id,
      category_id: input.category_id,
      started_at: input.started_at,
      ended_at: null,
      notes: null,
      ai_summary: null,
    };
    sessions = [created, ...sessions];
    return created;
  },

  async updateSession(sessionId: string, patch: Partial<MockSession>): Promise<void> {
    await delay();
    sessions = sessions.map((s) => (s.id === sessionId ? { ...s, ...patch } : s));
  },

  async getLatestSessionByUserAndCategory(userId: string, categoryId: string): Promise<MockSession | null> {
    await delay();
    return (
      sessions
        .filter((s) => s.user_id === userId && s.category_id === categoryId)
        .sort((a, b) => +new Date(b.started_at) - +new Date(a.started_at))[0] ?? null
    );
  },

  async getSessionsByUser(userId: string): Promise<MockSession[]> {
    await delay();
    return sessions.filter((s) => s.user_id === userId).sort((a, b) => +new Date(b.started_at) - +new Date(a.started_at));
  },

  async deleteSession(userId: string, sessionId: string): Promise<boolean> {
    await delay();
    const exists = sessions.some((s) => s.id === sessionId && s.user_id === userId);
    if (!exists) return false;
    sessions = sessions.filter((s) => !(s.id === sessionId && s.user_id === userId));
    messages = messages.filter((m) => m.session_id !== sessionId);
    recordings = recordings.filter((r) => r.session_id !== sessionId);
    return true;
  },

  async addMessage(input: Omit<MockMessage, "id" | "created_at"> & { created_at?: string }): Promise<MockMessage> {
    await delay();
    const created: MockMessage = {
      id: id("msg"),
      created_at: input.created_at ?? new Date().toISOString(),
      session_id: input.session_id,
      sender: input.sender,
      text: input.text,
      audio_url: input.audio_url ?? null,
    };
    messages = [...messages, created];
    return created;
  },

  async getMessagesBySession(sessionId: string): Promise<MockMessage[]> {
    await delay();
    return messages.filter((m) => m.session_id === sessionId).sort((a, b) => +new Date(a.created_at) - +new Date(b.created_at));
  },

  async getMessageCountBySession(sessionId: string): Promise<number> {
    await delay();
    return messages.filter((m) => m.session_id === sessionId).length;
  },

  async addRecording(input: Omit<MockRecording, "id" | "created_at"> & { created_at?: string }): Promise<MockRecording> {
    await delay();
    const created: MockRecording = {
      id: id("rec"),
      created_at: input.created_at ?? new Date().toISOString(),
      user_id: input.user_id,
      session_id: input.session_id,
      audio_url: input.audio_url,
      duration: input.duration,
    };
    recordings = [created, ...recordings];
    return created;
  },

  async getLatestRecordingBySession(sessionId: string): Promise<MockRecording | null> {
    await delay();
    return (
      recordings
        .filter((r) => r.session_id === sessionId)
        .sort((a, b) => +new Date(b.created_at) - +new Date(a.created_at))[0] ?? null
    );
  },

  async getRecordingsByUser(userId: string): Promise<MockRecording[]> {
    await delay();
    return recordings.filter((r) => r.user_id === userId);
  },
};
