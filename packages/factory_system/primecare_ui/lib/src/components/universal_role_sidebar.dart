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
                  final iconSize = 24.0 * layout.scaleFactor;
                  return BottomNavigationBarItem(
                    icon: Icon(item.icon, size: iconSize),
                    activeIcon: item.activeIcon != null
                        ? Icon(item.activeIcon, size: iconSize)
                        : null,
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
                final iconSize = 24.0 * layout.scaleFactor;
                return NavigationRailDestination(
                  icon: Icon(
                    item.icon,
                    size: iconSize,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  selectedIcon: item.activeIcon != null
                      ? Icon(
                          item.activeIcon,
                          size: iconSize,
                          color: theme.colorScheme.primary,
                        )
                      : Icon(
                          item.icon,
                          size: iconSize,
                          color: theme.colorScheme.primary,
                        ),
                  label: Padding(
                    padding: EdgeInsets.only(top: 4 * layout.scaleFactor),
                    child: Text(
                      item.label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: 12.0 * layout.scaleFactor,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            VerticalDivider(
              thickness: 1 * layout.scaleFactor,
              width: 1 * layout.scaleFactor,
              color: theme.colorScheme.outline,
            ),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }
}
