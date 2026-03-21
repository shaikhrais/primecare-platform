import 'package:primecare_mobile/l10n/app_localizations.dart';
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
        title: PrimeCareText('PrimeCare Client Portal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF0EA5E9),
        
      ),
      /* drawer: Drawer(
        child: PrimeCareListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimeCareIcon(Icons.family_restroom, size: 48, color: Colors.white),
                  SizedBox(height: 12),
                  PrimeCareText('Client & Family', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              leading: PrimeCareIcon(Icons.dashboard),
              title: PrimeCareText(AppLocalizations.of(context)!.homeDashboard),
              onTap: () {
                context.pop();
                context.go('/client/dashboard');
              },
            ),
            ListTile(
              leading: PrimeCareIcon(Icons.monitor_heart),
              title: PrimeCareText(AppLocalizations.of(context)!.wellnessPulse),
              onTap: () {
                context.pop();
                // context.go('/client/wellness');
              },
            ),
            Divider(),
            ListTile(
              leading: PrimeCareIcon(Icons.logout, color: Colors.red),
              title: PrimeCareText('Sign Out', style: TextStyle(color: Colors.red)),
              onTap: () async {
                context.pop();
                await apiClient.logout();
                if (context.mounted) context.go('/login');
              },
            ),
          ],
        ),
      ),
      */ body: child,
    );
  }
}
