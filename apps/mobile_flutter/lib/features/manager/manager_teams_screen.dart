import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ManagerTeamsScreen extends StatelessWidget {
  const ManagerTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team Compliance Roster')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Shift Density',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const TeamMemberAvatarPile(),
            const SizedBox(height: 32),
            const ComplianceExpiryGauge(),
            const Spacer(),
            PrimeButton(
              label: 'Export Compliance Report',
              isOutline: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
