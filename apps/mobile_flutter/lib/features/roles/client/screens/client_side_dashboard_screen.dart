import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';

class ClientSideDashboardScreen extends StatelessWidget {
  const ClientSideDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimeCareAppBar(title: 'Client Side Dashboard'),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          PrimeCareQuickActionsGrid(
            sectionTitle: "Client Self-Serve",
            actions: [
              PrimeCareActionItem(title: 'Client Pulse', icon: Icons.favorite, route: AppRoutes.clientPulse, color: Colors.redAccent),
              PrimeCareActionItem(title: 'Care Dispatch', icon: Icons.fire_truck, route: AppRoutes.clientDispatch, color: Color(0xFF1E88E5)),
              PrimeCareActionItem(title: 'Payments', icon: Icons.payment, route: AppRoutes.clientPayments, color: Colors.green),
              PrimeCareActionItem(title: 'Messages', icon: Icons.mail, route: AppRoutes.clientInbox, color: Colors.blueGrey),
            ]
          ),
          SizedBox(height: 24),
          Center(
            child: Text('Client Side view coming soon...'),
          ),
        ],
      ),
    );
  }
}
