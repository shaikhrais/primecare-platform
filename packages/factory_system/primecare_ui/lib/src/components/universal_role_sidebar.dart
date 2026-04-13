import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_core/flutter_core.dart';
import 'responsive_layout_manager.dart';

class UniversalRoleSidebar extends StatelessWidget {
  final Widget child;
  final String currentPath;
  final List<PrimeCareNavigationItem> items;
  final Color? activeColor;

  const UniversalRoleSidebar({
    super.key,
    required this.child,
    required this.currentPath,
    required this.items,
    this.activeColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    int currentIndex = items.indexWhere((item) => item.route == currentPath);
    if (currentIndex == -1) currentIndex = 0;

    return ResponsiveLayoutManager(
      mob: Scaffold(
        body: child,
        bottomNavigationBar: items.isNotEmpty
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                selectedItemColor: activeColor,
                unselectedItemColor: Theme.of(context).disabledColor,
                onTap: (index) {
                  if (index < items.length) context.go(items[index].route);
                },
                items: items.map((item) {
                  return BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    label: item.label,
                  );
                }).toList(),
              )
            : null,
      ),
      tab: _buildRailLayout(context, currentIndex, extended: false),
      oneK: _buildRailLayout(context, currentIndex, extended: false),
      twoK: _buildRailLayout(context, currentIndex, extended: true),
      threeK: _buildRailLayout(context, currentIndex, extended: true),
      fourK: _buildRailLayout(context, currentIndex, extended: true),
    );
  }

  Widget _buildRailLayout(
    BuildContext context,
    int currentIndex, {
    required bool extended,
  }) {
    return Scaffold(
      body: Row(
        children: [
          if (items.isNotEmpty) ...[
            NavigationRail(
              extended: extended,
              minExtendedWidth: 200,
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                if (index < items.length) context.go(items[index].route);
              },
              selectedIconTheme: IconThemeData(color: activeColor),
              selectedLabelTextStyle: TextStyle(
                color: activeColor,
                fontWeight: FontWeight.bold,
              ),
              destinations: items.map((item) {
                return NavigationRailDestination(
                  icon: Icon(item.icon),
                  selectedIcon: item.activeIcon != null
                      ? Icon(item.activeIcon)
                      : null,
                  label: Text(item.label),
                );
              }).toList(),
            ),
            const VerticalDivider(thickness: 1, width: 1),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }
}
