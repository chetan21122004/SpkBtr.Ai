import { useState, useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";
import * as LucideIcons from "lucide-react";

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

// Map icon names to Lucide icons
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
  // Add more mappings as needed
};

export const useCategories = () => {
  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    const loadCategories = async () => {
      try {
        const { data, error: fetchError } = await supabase
          .from("categories")
          .select("*")
          .eq("is_active", true)
          .order("display_order", { ascending: true });

        if (fetchError) throw fetchError;

        const categoriesWithIcons: Category[] = (data || []).map((cat) => {
          const icon = cat.icon_name ? iconMap[cat.icon_name] : undefined;
          return {
            ...cat,
            icon,
          };
        });

        setCategories(categoriesWithIcons);
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

