import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_core/flutter_core.dart';

class UniversalRoleSidebar extends ConsumerWidget {
  final Widget child;
  final String currentPath;
  final List<PrimeCareNavigationItem> items;

  const UniversalRoleSidebar({
    super.key,
    required this.child,
    required this.currentPath,
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentIndex = items.indexWhere((item) => item.route == currentPath);
    if (currentIndex == -1) currentIndex = 0;

    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    // Mobile layout
    if (layout.tier == ResolutionTier.mob) {
      return Scaffold(
        body: child,
        bottomNavigationBar: items.isNotEmpty
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                selectedItemColor: theme.colorScheme.primary,
                unselectedItemColor: theme.disabledColor,
                backgroundColor: theme.colorScheme.surface,
                elevation: 8,
                onTap: (index) {
                  if (index < items.length) context.go(items[index].route);
                },
                items: items.map((item) {
                  return BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    activeIcon: item.activeIcon != null ? Icon(item.activeIcon) : null,
                    label: item.label,
                  );
                }).toList(),
              )
            : null,
      );
    }

    // Tablet and Desktop layouts (Sidebar)
    return _buildRailLayout(context, currentIndex, layout);
  }

  Widget _buildRailLayout(
    BuildContext context,
    int currentIndex,
    LayoutConfig layout,
  ) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Row(
        children: [
          if (items.isNotEmpty) ...[
            NavigationRail(
              extended: layout.isExtended,
              minExtendedWidth: layout.sidebarWidth,
              selectedIndex: currentIndex,
              backgroundColor: theme.colorScheme.surface,
              onDestinationSelected: (index) {
                if (index < items.length) context.go(items[index].route);
              },
              destinations: items.map((item) {
                return NavigationRailDestination(
                  icon: Icon(item.icon),
                  selectedIcon: item.activeIcon != null
                      ? Icon(item.activeIcon)
                      : Icon(item.icon, color: theme.colorScheme.primary),
                  label: Text(
                    item.label,
                    style: const TextStyle(fontSize: 13),
                  ),
                );
              }).toList(),
            ),
            VerticalDivider(
              thickness: 1, 
              width: 1, 
              color: theme.colorScheme.outline,
            ),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }
}
