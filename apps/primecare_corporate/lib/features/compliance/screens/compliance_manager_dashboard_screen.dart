// Governance - Category: view | Purpose: UI Screen component rendering the Compliance Manager Dashboard Screen workspace interface.
import 'package:flutter/material.dart';

class ComplianceManagerDashboardScreen extends StatefulWidget {
  const ComplianceManagerDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ComplianceManagerDashboardScreen> createState() => _ComplianceManagerDashboardScreenState();
}

class _ComplianceManagerDashboardScreenState extends State<ComplianceManagerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Legal & Compliance'), backgroundColor: Colors.brown.shade800),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            const Text('HIPAA & SOC2 Compliance Logs', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  Icon(Icons.verified_user, size: 80, color: Colors.green),
                  SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enterprise Compliance Verified', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                        SizedBox(height: 8),
                        Text('All cloud infrastructure and internal tooling are currently meeting PHI, HIPAA, and SOC2 Type II standards.'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Active Legal Incidents', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Card(
              child: ListTile(
                leading: Icon(Icons.gavel, color: Colors.brown),
                title: Text('No active incidents reported.'),
                subtitle: Text('Last updated: Just now.'),
              ),
            )
          ],
        ),
        ),
      ),
      ),
    );
  }
}
