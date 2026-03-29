import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';


class OperationsMgrDashboardScreen extends StatelessWidget {
  const OperationsMgrDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Operations Manager Dashboard',
      subtitle: 'Franchise Divisional Operations Module',
      kpiCards: [
        PrimeCareKpiCard(title: 'Active Territories', value: '42', icon: Icons.map, subtitle: '+2 pending'),
        PrimeCareKpiCard(title: 'Franchise Revenue', value: '\$1.2M', icon: Icons.request_quote, subtitle: 'Q3 Projection'),
        PrimeCareKpiCard(title: 'Compliance Rate', value: '98%', icon: Icons.verified, subtitle: 'Perfect'),
        PrimeCareKpiCard(title: 'Open Disputes', value: '3', icon: Icons.warning_amber, subtitle: 'Review Required'),
      ],
      children: [
        const SizedBox(height: 24),
        PrimeCareResponsiveKpiGrid(
          children: [
            SizedBox(
              child: PrimeCareCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PrimeCareSectionHeader(title: 'Active Operations Feed', isWhite: true),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade50,
                            child: const Icon(Icons.analytics, color: Colors.blue),
                          ),
                          title: Text('Automated franchise Report Generation - Batch ${index + 1}'),
                          subtitle: const Text('Systems Nominal • Synced just now'),
                          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                        );
                      },
                    )
                  ]
                )
              )
            ),
            const SizedBox(width: 16),
            SizedBox(
              child: PrimeCareCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const PrimeCareSectionHeader(title: 'Quick Module Actions', isWhite: true),
                     const SizedBox(height: 16),
                     ElevatedButton.icon(
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloading Report Data...')));
                      },
                      icon: const Icon(Icons.download, color: Colors.white),
                      label: const Text('Export Weekly Summary', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E88E5),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Configuration Options Opened.')));
                      },
                      icon: const Icon(Icons.settings, color: Color(0xFF1E3A8A)),
                      label: const Text('Module Configurations', style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.bold)),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    )
                  ]
                )
              )
            )
          ]
        )
      ],
    );
  }
}
