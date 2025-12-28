import { NavLink } from "react-router-dom";
import {
  Home,
  Target,
  Folder,
  TrendingUp,
  Mic,
  MessageSquare,
  ChevronDown,
} from "lucide-react";
import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarHeader,
} from "@/components/ui/sidebar";
import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import { useState } from "react";
import { useCategories } from "@/hooks/useCategories";

const mainItems = [
  { title: " Dashboard", url: "/", icon: Home },
  { title: "Goals/Challenges", url: "/goals", icon: Target },
];

const bottomItems = [
  { title: " Analytics", url: "/progress", icon: TrendingUp },
  { title: "History", url: "/recordings", icon: Mic },
  { title: "Community ", url: "/community", icon: MessageSquare },
];

export function AppSidebar() {
  const [categoriesOpen, setCategoriesOpen] = useState(true);
  const { categories, loading } = useCategories();

  return (
    <Sidebar>
      <SidebarHeader className="border-b border-sidebar-border p-4">
        <h2 className="text-lg font-bold bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
          Voice Coach AI
        </h2>
      </SidebarHeader>

      <SidebarContent>
        <SidebarGroup>
          <SidebarMenu>
            {mainItems.map((item) => (
              <SidebarMenuItem key={item.title}>
                <SidebarMenuButton asChild>
                  <NavLink to={item.url} end>
                    <item.icon />
                    <span>{item.title}</span>
                  </NavLink>
                </SidebarMenuButton>
              </SidebarMenuItem>
            ))}
          </SidebarMenu>
        </SidebarGroup>

        <Collapsible open={categoriesOpen} onOpenChange={setCategoriesOpen}>
          <SidebarGroup>
            <CollapsibleTrigger className="w-full">
              <SidebarGroupLabel className="flex items-center justify-between w-full cursor-pointer hover:bg-sidebar-accent rounded-md">
                <div className="flex items-center gap-2">
                  <Folder className="w-4 h-4" />
                  <span>Categories</span>
                </div>
                <ChevronDown
                  className={`w-4 h-4 transition-transform ${categoriesOpen ? "rotate-180" : ""}`}
                />
              </SidebarGroupLabel>
            </CollapsibleTrigger>

            <CollapsibleContent>
              <SidebarGroupContent>
                <SidebarMenu>
                  {loading ? (
                    <SidebarMenuItem>
                      <SidebarMenuButton disabled>
                        <span>Loading...</span>
                      </SidebarMenuButton>
                    </SidebarMenuItem>
                  ) : (
                    categories.map((category) => {
                      if (!category.icon || !category.route_path) return null;
                      const Icon = category.icon;
                      return (
                        <SidebarMenuItem key={category.id}>
                          <SidebarMenuButton asChild tooltip={category.description || ""}>
                            <NavLink to={category.route_path}>
                              <Icon />
                              <span>{category.name}</span>
                            </NavLink>
                          </SidebarMenuButton>
                        </SidebarMenuItem>
                      );
                    })
                  )}
                </SidebarMenu>
              </SidebarGroupContent>
            </CollapsibleContent>
          </SidebarGroup>
        </Collapsible>

        <SidebarGroup>
          <SidebarMenu>
            {bottomItems.map((item) => (
              <SidebarMenuItem key={item.title}>
                <SidebarMenuButton asChild>
                  <NavLink to={item.url}>
                    <item.icon />
                    <span>{item.title}</span>
                  </NavLink>
                </SidebarMenuButton>
              </SidebarMenuItem>
            ))}
          </SidebarMenu>
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
  );
}
