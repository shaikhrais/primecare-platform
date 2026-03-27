import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_mobile/core/routing/sidebar_config.dart';

import 'package:primecare_mobile/features/roles/psw/psw_sidebar_config.dart';
import 'package:primecare_mobile/features/roles/rn/rn_sidebar_config.dart';
import 'package:primecare_mobile/features/roles/coordinator/coordinator_sidebar_config.dart';
import 'package:primecare_mobile/features/roles/manager/manager_sidebar_config.dart';
import 'package:primecare_mobile/features/roles/admin/admin_sidebar_config.dart';
import 'package:primecare_mobile/features/roles/client/client_sidebar_config.dart';
import 'package:primecare_mobile/features/roles/gm/gm_sidebar_config.dart';
import 'package:primecare_mobile/features/roles/mt/mt_sidebar_config.dart';
import 'package:primecare_mobile/features/roles/superuser/superuser_sidebar_config.dart';
import 'package:primecare_mobile/features/master/shared/thin_hub_sidebar_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/auth/auth_provider.dart';

class UniversalRoleSidebar extends ConsumerWidget {
  final Widget child;
  final String currentPath;

  const UniversalRoleSidebar({
    super.key,
    required this.child,
    required this.currentPath,
  });

  SidebarConfig _getConfig(String role) {
    switch (role) {
      case 'rn': return rnSidebarConfig;
      case 'coordinator': return coordinatorSidebarConfig;
      case 'manager': return managerSidebarConfig;
      case 'admin': return adminSidebarConfig;
      case 'client': return clientSidebarConfig;
      case 'gm': return gmSidebarConfig;
      case 'mt': return mtSidebarConfig;
      case 'superuser': return superuserSidebarConfig;
      case 'thin-hub': return thinHubSidebarConfig;
      default: return pswSidebarConfig;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userRole = authState.role ?? 'psw';
    final config = _getConfig(userRole);
    final activeColor = config.activeColor;
    final paths = config.paths;
    final items = config.items;

    int currentIndex = paths.indexWhere((p) => p == currentPath);
    if (currentIndex == -1) currentIndex = 0;

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
                    unselectedItemColor: Colors.grey,
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
                    unselectedIconTheme: const IconThemeData(color: Colors.grey),
                    unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
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
