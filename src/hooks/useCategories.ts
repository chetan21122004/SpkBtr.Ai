import { useState, useEffect } from "react";
import * as LucideIcons from "lucide-react";
import { mockDb } from "@/mocks/mockDb";

export interface Category {
  id: string;
  name: string;
  description: string | null;
  base_context: string;
  route_path: string | null;
  icon_name: string | null;
  gradient: string | null;
  display_order: number;
  is_active: boolean;
  icon?: LucideIcons.LucideIcon;
}

export const useCategories = () => {
  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    const loadCategories = async () => {
      try {
        const data = await mockDb.getCategories();
        setCategories(data as Category[]);
        setLoading(false);
      } catch (err) {
        setError(err as Error);
        setLoading(false);
      }
    };

    loadCategories();
  }, []);

  return { categories, loading, error };
};

