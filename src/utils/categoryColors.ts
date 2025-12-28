/**
 * Maps category names to their specific color gradient schemes
 * Returns Tailwind gradient classes for primary and accent colors
 */
export const getCategoryColors = (categoryName: string): { primary: string; accent: string } => {
  const colorMap: Record<string, { primary: string; accent: string }> = {
    "Daily Conversations": {
      primary: "from-blue-500",
      accent: "to-purple-500",
    },
    "Confidence & Mindset": {
      primary: "from-green-500",
      accent: "to-teal-500",
    },
    "Public Speaking": {
      primary: "from-orange-500",
      accent: "to-red-500",
    },
    "Interview Practice": {
      primary: "from-blue-500",
      accent: "to-indigo-500",
    },
    "Emotional Expression": {
      primary: "from-pink-500",
      accent: "to-purple-500",
    },
    "Voice Clarity": {
      primary: "from-cyan-500",
      accent: "to-blue-500",
    },
    "Group Communication": {
      primary: "from-yellow-500",
      accent: "to-orange-500",
    },
  };

  return colorMap[categoryName] || { primary: "from-primary", accent: "to-accent" };
};

