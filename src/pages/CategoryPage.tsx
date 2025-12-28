import { useLocation, Navigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import WaveformVisualizer from "@/components/WaveformVisualizer";
import { useVoiceConversation } from "@/hooks/useVoiceConversation";
import { useCategories } from "@/hooks/useCategories";
import { useAuth } from "@/hooks/useAuth";
import { useEffect, useState } from "react";
import AISpeakingAnimation from "@/components/AISpeakingAnimation";
import { Loader2 } from "lucide-react";

const CategoryPage = () => {
  const location = useLocation();
  const { categories, loading: categoriesLoading } = useCategories();
  const { user } = useAuth();
  const [categoryName, setCategoryName] = useState<string | null>(null);
  const [categoryDescription, setCategoryDescription] = useState<string | null>(null);
  const [hasSearched, setHasSearched] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  // Find category by current route path
  useEffect(() => {
    if (!categoriesLoading && categories.length > 0) {
      setHasSearched(true); // Mark that we've searched
      
      // Normalize pathname (remove trailing slash if present)
      const normalizedPath = location.pathname.replace(/\/$/, '') || '/';
      
      console.log('🔍 Looking for category with path:', normalizedPath);
      console.log('📋 Available categories:', categories.map(c => ({ 
        name: c.name, 
        route_path: c.route_path 
      })));
      
      const category = categories.find(
        (cat) => {
          if (!cat.route_path) {
            console.log(`⚠️ Category "${cat.name}" has no route_path`);
            return false;
          }
          // Normalize route_path too
          const normalizedRoute = cat.route_path.replace(/\/$/, '') || '/';
          const matches = normalizedRoute === normalizedPath;
          console.log(`🔗 Comparing: "${normalizedRoute}" === "${normalizedPath}" = ${matches}`);
          return matches;
        }
      );
      
      if (category) {
        console.log('✅ Found category:', category.name);
        setCategoryName(category.name);
        setCategoryDescription(category.description);
      } else {
        // Debug: log what we're looking for
        console.error('❌ Category not found for path:', normalizedPath);
        console.error('Available routes:', categories.map(c => c.route_path).filter(Boolean));
        // Reset if category not found
        setCategoryName(null);
        setCategoryDescription(null);
      }
    } else if (!categoriesLoading && categories.length === 0) {
      console.warn('⚠️ No categories loaded');
      setHasSearched(true);
    }
  }, [location.pathname, categories, categoriesLoading]);

  // Only initialize hook when categoryName is available
  const { audioRef, isListening, startSession, stopSession, isAISpeaking } = useVoiceConversation({
    categoryName: categoryName || "",
    userId: user?.id,
  });

  if (categoriesLoading) {
    return (
      <div className="min-h-screen bg-background p-6">
        <div className="max-w-4xl mx-auto space-y-8">
          <div className="text-center">
            <p className="text-muted-foreground">Loading category...</p>
          </div>
        </div>
      </div>
    );
  }

  // Show loading if we haven't searched yet
  if (!hasSearched) {
    return (
      <div className="min-h-screen bg-background p-6">
        <div className="max-w-4xl mx-auto space-y-8">
          <div className="text-center">
            <p className="text-muted-foreground">Loading category...</p>
          </div>
        </div>
      </div>
    );
  }

  // Only redirect AFTER we've searched and category not found
  if (hasSearched && !categoriesLoading && categories.length > 0 && !categoryName) {
    return <Navigate to="/categories" replace />;
  }

  // Show error if categories loaded but none found
  if (hasSearched && !categoriesLoading && categories.length === 0) {
    return (
      <div className="min-h-screen bg-background p-6">
        <div className="max-w-4xl mx-auto space-y-8">
          <div className="text-center">
            <p className="text-muted-foreground">No categories available</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-4xl mx-auto space-y-8">
        <div className="text-center space-y-2">
          <h1 className="text-4xl font-bold text-foreground">{categoryName} Practice</h1>
          <p className="text-muted-foreground">
            {categoryDescription || "Record your speech and receive AI-powered feedback"}
          </p>
        </div>

        {/* AI Speaking Animation */}
        {categoryName && (
          <AISpeakingAnimation 
            isListening={isListening}
            audioRef={audioRef}
            categoryName={categoryName}
            size="large"
            onLoadingChange={setIsLoading}
          />
        )}

        <div className="space-y-8 animate-fade-in">
          <Button 
            size="xl" 
            variant="default"
            onClick={isListening ? stopSession : startSession}
            className="w-full"
            disabled={isLoading && !isListening}
          >
            {isLoading && !isListening ? (
              <>
                <Loader2 className="w-5 h-5 mr-2 animate-spin" />
                Connecting...
              </>
            ) : (
              <>
                {isListening ? "Stop Session" : "Start Coaching Session"}
              </>
            )}
          </Button>

          {isListening && (
            <div className="text-center space-y-4">
              <WaveformVisualizer isActive={isListening} status="listening" />
            </div>
          )}

          <audio ref={audioRef} className="hidden" />
        </div>
      </div>
    </div>
  );
};

export default CategoryPage;

