import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import { SidebarProvider, SidebarTrigger } from "@/components/ui/sidebar";
import { AppSidebar } from "@/components/AppSidebar";
import { Navbar } from "@/components/Navbar";
import { AuthGuard } from "@/components/AuthGuard";
import Dashboard from "./pages/Dashboard";
import Goals from "./pages/Goals";
import Categories from "./pages/Categories";
import CategoryPage from "./pages/CategoryPage";
import Progress from "./pages/Progress";
import Recordings from "./pages/Recordings";
import Community from "./pages/Community";
import Login from "./pages/Login";
import Signup from "./pages/Signup";
import NotFound from "./pages/NotFound";
import { useCategories } from "./hooks/useCategories";
import "./utils/storageDebug"; // Load storage debug utilities

// Import specific category page components
import DailyConversations from "./pages/DailyConversations";
import EmotionalExpression from "./pages/EmotionalExpression";
import InterviewPractice from "./pages/InterviewPractice";
import VoiceClarity from "./pages/VoiceClarity";
import PublicSpeaking from "./pages/PublicSpeaking";
import GroupCommunication from "./pages/GroupCommunication";
import ConfidenceMindset from "./pages/ConfidenceMindset";

const queryClient = new QueryClient();

// Map category names to their specific page components
const categoryComponentMap: Record<string, React.ComponentType> = {
  "Daily Conversations": DailyConversations,
  "Emotional Expression": EmotionalExpression,
  "Interview Practice": InterviewPractice,
  "Voice Clarity": VoiceClarity,
  "Public Speaking": PublicSpeaking,
  "Group Communication": GroupCommunication,
  "Confidence & Mindset": ConfidenceMindset,
};

const AppRoutes = () => {
  const { categories, loading: categoriesLoading } = useCategories();

  // Wait for categories to load before rendering routes
  if (categoriesLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <p className="text-muted-foreground">Loading routes...</p>
      </div>
    );
  }

  console.log('🚀 AppRoutes: Categories loaded:', categories.length);
  console.log('📝 Routes to register:', categories.map(c => ({ name: c.name, path: c.route_path })));

  return (
    <Routes>
      {/* Public routes */}
      <Route path="/login" element={<Login />} />
      <Route path="/signup" element={<Signup />} />
      
      {/* Protected routes */}
      <Route
        path="/"
        element={
          <AuthGuard>
            <Dashboard />
          </AuthGuard>
        }
      />
      <Route
        path="/goals"
        element={
          <AuthGuard>
            <Goals />
          </AuthGuard>
        }
      />
      <Route
        path="/categories"
        element={
          <AuthGuard>
            <Categories />
          </AuthGuard>
        }
      />
      {/* Generate dynamic routes for each category */}
      {categories.map((category) => {
        if (!category.route_path) {
          console.warn(`⚠️ Category "${category.name}" has no route_path, skipping route`);
          return null;
        }
        
        // Use specific component if available, otherwise use generic CategoryPage
        const CategoryComponent = categoryComponentMap[category.name] || CategoryPage;
        const componentName = categoryComponentMap[category.name] ? "specific component" : "generic CategoryPage";
        
        console.log(`✅ Registering route: ${category.route_path} for "${category.name}" using ${componentName}`);
        return (
          <Route
            key={category.id}
            path={category.route_path}
            element={
              <AuthGuard>
                <CategoryComponent />
              </AuthGuard>
            }
          />
        );
      })}
      <Route
        path="/progress"
        element={
          <AuthGuard>
            <Progress />
          </AuthGuard>
        }
      />
      <Route
        path="/recordings"
        element={
          <AuthGuard>
            <Recordings />
          </AuthGuard>
        }
      />
      <Route
        path="/community"
        element={
          <AuthGuard>
            <Community />
          </AuthGuard>
        }
      />
      {/* ADD ALL CUSTOM ROUTES ABOVE THE CATCH-ALL "*" ROUTE */}
      <Route path="*" element={<NotFound />} />
    </Routes>
  );
};

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner />
      <BrowserRouter>
        <SidebarProvider>
          <div className="flex min-h-screen w-full">
            <AppSidebar />
            <main className="flex-1 relative">
              <Navbar />
              <SidebarTrigger className="fixed top-4 left-4 z-50" />
              <div className="pt-16">
                <AppRoutes />
              </div>
            </main>
          </div>
        </SidebarProvider>
      </BrowserRouter>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;
