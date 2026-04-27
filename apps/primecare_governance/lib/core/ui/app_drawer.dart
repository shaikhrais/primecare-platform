import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../governance/screen_registry.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // In real app, get role from provider
    const String userRole = 'admin';

    final allowedScreens = ScreenRegistry.screens.values.where(
      (s) => s.allowedRoles.contains(userRole) && s.icon != null
    ).toList();

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                'PrimeCare Enterprise',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: allowedScreens.length,
              itemBuilder: (context, index) {
                final screen = allowedScreens[index];
                return ListTile(
                  leading: Icon(screen.icon),
                  title: Text(screen.title),
                  onTap: () {
                    context.go(screen.routePath);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
