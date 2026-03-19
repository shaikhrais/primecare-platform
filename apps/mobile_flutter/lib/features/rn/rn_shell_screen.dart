import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/api_client.dart';

class RnShellScreen extends StatelessWidget {
  final Widget child;
  const RnShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrimeCare Clinical', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0D9488), // Teal for Clinical
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0D9488)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.local_hospital, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  Text('Registered Nurse (RN)', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Clinical Dashboard'),
              onTap: () {
                context.pop();
                context.go('/rn/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: const Text('Bento Assessments'),
              onTap: () {
                context.pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.medication),
              title: const Text('MAR & Care Plans'),
              onTap: () {
                context.pop();
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
