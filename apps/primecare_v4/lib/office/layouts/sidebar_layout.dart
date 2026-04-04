import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/glass_surface.dart';
import '../../services/auth_service.dart';
import 'sidebar_config.dart';
import '../../routes/app_routes.dart';

class SidebarLayout extends ConsumerWidget {
  const SidebarLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Fetch authorized role
    final role = ref.watch(authProvider).role ?? '';
    
    // 2. Extract precisely the 10-15 buttons defined for this role
    final menuItems = SidebarConfig.getMenuForRole(role);

    return GlassSurface(
      borderRadius: 0,
      hasGhostBorder: false, // "Avoid vertical lines"
      child: Container(
        width: 250,
        color: Colors.transparent, // Inherit glass blur
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 16.0),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];

            // 3. Resolve the targeted GoRouter path logically
            String targetRoute = '';
            if (item.label.toLowerCase() == 'dashboard') {
              targetRoute = AuthNotifier.getDashboardRouteForRole(role);
            } else if (item.label.toLowerCase() == 'settings') {
              targetRoute = AppRoutes.globalSettings;
            } else if (item.label.toLowerCase() == 'messages' || item.label.toLowerCase() == 'chat') {
              targetRoute = AppRoutes.messagingHub;
            } else if (item.label.toLowerCase() == 'documents') {
              targetRoute = AppRoutes.documentVault;
            } else if (item.label.toLowerCase() == 'notifications') {
              targetRoute = AppRoutes.notificationCenter;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: Icon(item.icon, size: 22, color: const Color(0xFF006565)),
                title: Text(
                  item.label, 
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.blueGrey)
                ),
                onTap: () {
                  if (targetRoute.isNotEmpty) {
                    context.go(targetRoute);
                  } else {
                    final formattedId = item.label.toLowerCase().replaceAll(' ', '_');
                    context.go('/provider/feature/$formattedId');
                  }
                },
                hoverColor: const Color(0xFF006565).withValues(alpha: 0.05),
              ),
            );
          },
        ),
      ),
    );
  }
}
