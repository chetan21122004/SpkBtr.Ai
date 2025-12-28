import { Card, CardContent } from "@/components/ui/card";
import { useNavigate } from "react-router-dom";
import { useCategories } from "@/hooks/useCategories";

const Categories = () => {
  const navigate = useNavigate();
  const { categories, loading, error } = useCategories();

  if (loading) {
    return (
      <div className="min-h-screen bg-background p-6">
        <div className="max-w-6xl mx-auto space-y-6">
          <div className="text-center">
            <p className="text-muted-foreground">Loading categories...</p>
          </div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="min-h-screen bg-background p-6">
        <div className="max-w-6xl mx-auto space-y-6">
          <div className="text-center">
            <p className="text-destructive">Error loading categories: {error.message}</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background p-6">
      <div className="max-w-6xl mx-auto space-y-6">
        <div className="space-y-2">
          <h1 className="text-4xl font-bold text-foreground">Choose Your Practice</h1>
          <p className="text-muted-foreground">Select a category to start improving your communication skills</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {categories.map((category) => {
            const Icon = category.icon;
            if (!Icon || !category.route_path) return null;
            
            return (
              <Card 
                key={category.id} 
                className="group cursor-pointer hover:scale-105 transition-all duration-300 hover:shadow-2xl overflow-hidden border-0 relative"
                onClick={() => {
                  console.log('🖱️ Clicked category:', category.name, 'navigating to:', category.route_path);
                  navigate(category.route_path!);
                }}
              >
                <div 
                  className={`absolute inset-0 bg-gradient-to-br opacity-90 ${
                    category.gradient && category.gradient.trim()
                      ? category.gradient.trim()
                      : "from-primary to-accent"
                  }`}
                  style={category.gradient && category.gradient.includes('rgb') ? {
                    background: category.gradient
                  } : undefined}
                />
                <CardContent className="relative p-6 text-white space-y-4 z-10">
                  <Icon className="w-12 h-12 group-hover:scale-110 transition-transform" />
                  <div className="space-y-2">
                    <h3 className="text-2xl font-bold">{category.name}</h3>
                    <p className="text-white/90 text-sm">{category.description || ""}</p>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      </div>
    </div>
  );
};

export default Categories;
