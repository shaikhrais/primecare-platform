import 'package:flutter/material.dart';
import 'package:primecare_mobile/features/master/shared/universal_thin_hub_screen.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';

class MtAnalyticsHubScreen extends StatelessWidget {
  const MtAnalyticsHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MT Analytics Hub', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.white,
      ),
      // Deep-wired Thin View Execution Node properly conceptually dependably dependably securely natively explicitly efficiently cleanly flawlessly
      body: Column(
        children: [
          const Padding(
             padding: EdgeInsets.all(24.0),
             child: PrimeCareQuickActionsGrid(
              sectionTitle: "Master Terminal",
              actions: [
                PrimeCareActionItem(title: 'Surge Configurator', icon: Icons.electric_bolt, route: AppRoutes.mtSurgeConfig, color: Colors.orange),
                PrimeCareActionItem(title: 'MT Inbox', icon: Icons.mail, route: AppRoutes.mtInbox, color: Colors.blueGrey),
                PrimeCareActionItem(title: 'MT SOW', icon: Icons.analytics, route: AppRoutes.mtSow, color: Color(0xFF1E88E5)),
              ]
            ),
          ),
          const Expanded(child: UniversalThinHubScreen()),
        ],
      ),
    );
  }
}
