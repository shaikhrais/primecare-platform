import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_core/flutter_core.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;

  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Console',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            key: const Key('data-status-id=shared-global-admin-action-1'),
            icon: const Icon(Icons.notifications),
            onPressed: () => context.go(CommonRoutes.notificationCenter),
          ),
          IconButton(
            key: const Key('data-status-id=shared-global-admin-action-3'),
            icon: const Icon(Icons.account_circle),
            onPressed: () => context.go(CommonRoutes.globalProfile),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          final sidebar = Container(
            width: 250,
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            child: ListView(
              children: [
                ListTile(
                  key: const Key('data-status-id=shared-global-admin-action-5'),
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Executive Dashboard'),
                  onTap: () {
                    context.go(CorporateRoutes.ceoDashboard);
                    if (isMobile) Navigator.pop(context);
                  },
                ),
                ListTile(
                  key: const Key('data-status-id=shared-global-admin-action-7'),
                  leading: const Icon(Icons.analytics),
                  title: const Text('Global Reports'),
                  onTap: () {
                    context.go(CorporateRoutes.complianceManagerDashboard);
                    if (isMobile) Navigator.pop(context);
                  },
                ),
                ListTile(
                  key: const Key('data-status-id=shared-global-admin-action-9'),
                  leading: const Icon(Icons.settings),
                  title: const Text('System Settings'),
                  onTap: () {
                    context.go(CommonRoutes.globalSettings);
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
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text(
                      'Admin Console',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    key: const Key(
                      'data-status-id=shared-global-admin-action-11',
                    ),
                    leading: const Icon(Icons.dashboard),
                    title: const Text('Executive Dashboard'),
                    onTap: () {
                      context.go(CorporateRoutes.ceoDashboard);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    key: const Key(
                      'data-status-id=shared-global-admin-action-13',
                    ),
                    leading: const Icon(Icons.analytics),
                    title: const Text('Global Reports'),
                    onTap: () {
                      context.go(CorporateRoutes.complianceManagerDashboard);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    key: const Key(
                      'data-status-id=shared-global-admin-action-15',
                    ),
                    leading: const Icon(Icons.settings),
                    title: const Text('System Settings'),
                    onTap: () {
                      context.go(CommonRoutes.globalSettings);
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

// Using dynamicPageProvider and ViewModel pattern for data binding.
