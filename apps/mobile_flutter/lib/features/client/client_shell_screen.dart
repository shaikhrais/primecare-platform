import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/api_client.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClientShellScreen extends StatelessWidget {
  final Widget child;
  const ClientShellScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: PrimeCareNavBar(
        title: const PrimeCareText('PrimeCare Client Portal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0EA5E9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: PrimeCareListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimeCareIcon(Icons.family_restroom, size: 48, color: Colors.white),
                  PrimeCareSizedBox(height: 12),
                  PrimeCareText('Client & Family', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: const PrimeCareIcon(Icons.dashboard),
              title: const PrimeCareText('Home Dashboard'),
              onTap: () {
                context.pop();
                context.go('/client/dashboard');
              },
            ),
            ListTile(
              leading: const PrimeCareIcon(Icons.monitor_heart),
              title: const PrimeCareText('Wellness Pulse'),
              onTap: () {
                context.pop();
                // context.go('/client/wellness');
              },
            ),
            const Divider(),
            ListTile(
              leading: const PrimeCareIcon(Icons.logout, color: Colors.red),
              title: const PrimeCareText('Sign Out', style: TextStyle(color: Colors.red)),
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
