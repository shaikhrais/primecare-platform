import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_routes.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  
  const AdminLayout({Key? key, required this.child}) : super(key: key);

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
      body: Row(
        children: [
          // Basic Admin Navigation Sidebar
          Container(
            width: 250,
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Executive Dashboard'),
                  // Using context.go ensures ONLY the nested child rebuilds, preserving TopBar and Sidebar completely.
                  onTap: () => context.go(AppRoutes.ceoDashboard),
                ),
                ListTile(
                  leading: const Icon(Icons.analytics),
                  title: const Text('Global Reports'),
                  // Simulating another view in the same shell
                  onTap: () => context.go(AppRoutes.complianceManagerDashboard),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('System Settings'),
                  onTap: () => context.go(AppRoutes.globalSettings),
                ),
              ],
            ),
          ),
          // Main Content perfectly isolated. Only this widget rebuilds on context.go()
          Expanded(child: child),
        ],
      ),
    );
  }
}
