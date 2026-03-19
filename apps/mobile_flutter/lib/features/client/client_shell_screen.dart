import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/api_client.dart';

class ClientShellScreen extends StatelessWidget {
  final Widget child;
  const ClientShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrimeCare Client Portal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0EA5E9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0EA5E9)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.family_restroom, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  Text('Client & Family', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Home Dashboard'),
              onTap: () {
                context.pop();
                context.go('/client/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor_heart),
              title: const Text('Wellness Pulse'),
              onTap: () {
                context.pop();
                // context.go('/client/wellness');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
              onTap: () async {
                context.pop();
                await apiClient.logout();
                if (context.mounted) context.go('/login');
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
