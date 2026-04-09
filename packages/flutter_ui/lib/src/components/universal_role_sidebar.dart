import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UniversalRoleSidebar extends StatelessWidget {
  final Widget child;
  final String currentPath;

  const UniversalRoleSidebar({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    // A completely generic enterprise sidebar spanning the 36-role domain organically.
    // Detaches entirely from legacy primecare_mobile static configurations cleanly conceptually safely.
    
    final activeColor = Colors.teal;
    final items = [
      const BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
      const BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Inbox'),
      const BottomNavigationBarItem(icon: Icon(Icons.assessment_outlined), label: 'Reports'),
      const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurations'),
    ];
    final paths = ['/', '/inbox', '/reports', '/configurations'];

    int currentIndex = 0;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Scaffold(
            body: child,
            bottomNavigationBar: items.length > 1
                ? BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: currentIndex,
                    selectedItemColor: activeColor,
                    unselectedItemColor: Theme.of(context).disabledColor,
                    onTap: (index) {
                      if (index < paths.length) context.go(paths[index]);
                    },
                    items: items,
                  )
                : null,
          );
        } else {
          final isDesktop = constraints.maxWidth >= 1024;
          return Scaffold(
            body: Row(
              children: [
                if (items.length > 1) ...[
                  NavigationRail(
                    extended: isDesktop,
                    minExtendedWidth: 200,
                    selectedIndex: currentIndex,
                    onDestinationSelected: (index) {
                      if (index < paths.length) context.go(paths[index]);
                    },
                    selectedIconTheme: IconThemeData(color: activeColor),
                    selectedLabelTextStyle: TextStyle(color: activeColor, fontWeight: FontWeight.bold),
                    unselectedIconTheme: IconThemeData(color: Theme.of(context).disabledColor),
                    unselectedLabelTextStyle: TextStyle(color: Theme.of(context).disabledColor),
                    destinations: items.map((item) {
                      return NavigationRailDestination(
                        icon: item.icon,
                        selectedIcon: item.activeIcon ?? item.icon,
                        label: Text(item.label ?? ''),
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
      },
    );
  }
}
