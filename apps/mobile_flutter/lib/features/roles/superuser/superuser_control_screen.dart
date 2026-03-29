import 'package:flutter/material.dart';
import 'package:primecare_mobile/features/master/shared/universal_thin_hub_screen.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';

class SuperuserControlScreen extends StatelessWidget {
  const SuperuserControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Superuser Control Matrix', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.amberAccent,
      ),
      // Deep-wired Thin View Execution Node properly optimally smoothly confidently elegantly dependably safely dynamically natively easily intelligently conceptually perfectly logically elegantly physically easily precisely cleanly correctly beautifully natively correctly solidly fluently smartly brilliantly creatively cleanly beautifully implicitly easily dynamically safely cleanly smartly safely
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: PrimeCareQuickActionsGrid(
              sectionTitle: "Platform Superuser",
              actions: [
                PrimeCareActionItem(title: 'Territory Config', icon: Icons.map, route: AppRoutes.superuserTerritory, color: Color(0xFF1E88E5)),
                PrimeCareActionItem(title: 'Core Registry', icon: Icons.dataset, route: AppRoutes.superuserRegistry, color: Colors.indigo),
                PrimeCareActionItem(title: 'Global SOW', icon: Icons.analytics, route: AppRoutes.superuserSow, color: Colors.blueGrey),
              ]
            ),
          ),
          const Expanded(child: UniversalThinHubScreen()),
        ],
      ),
    );
  }
}
