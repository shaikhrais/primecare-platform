import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_routes.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  
  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Console', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications), 
            onPressed: () => context.go(AppRoutes.notificationCenter)
          ),
          IconButton(
            icon: const Icon(Icons.account_circle), 
            onPressed: () => context.go(AppRoutes.globalProfile)
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;
          
          final sidebar = Container(
            width: 250,
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Executive Dashboard'),
                  onTap: () {
                    context.go(AppRoutes.ceoDashboard);
                    if (isMobile) Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.analytics),
                  title: const Text('Global Reports'),
                  onTap: () {
                    context.go(AppRoutes.complianceManagerDashboard);
                    if (isMobile) Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('System Settings'),
                  onTap: () {
                    context.go(AppRoutes.globalSettings);
                    if (isMobile) Navigator.pop(context);
                  },
                ),
              ],
            ),
          );

          if (isMobile) {
            return child;
          }
          
          return Row(
            children: [
              sidebar,
              Expanded(child: child),
            ],
          );
        },
      ),
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;
          
          if (!isMobile) return const SizedBox.shrink();
          
          return Drawer(
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                    child: const Text('Admin Console', style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text('Executive Dashboard'),
                    onTap: () {
                      context.go(AppRoutes.ceoDashboard);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.analytics),
                    title: const Text('Global Reports'),
                    onTap: () {
                      context.go(AppRoutes.complianceManagerDashboard);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('System Settings'),
                    onTap: () {
                      context.go(AppRoutes.globalSettings);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
