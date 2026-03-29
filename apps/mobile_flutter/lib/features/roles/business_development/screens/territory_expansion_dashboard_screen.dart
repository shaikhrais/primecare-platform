import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';


class TerritoryExpansionDashboardScreen extends StatelessWidget {
  const TerritoryExpansionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Territory Expansion Manager Dashboard',
      subtitle: 'Business Divisional Operations Module',
      kpiCards: [
        PrimeCareKpiCard(title: 'Active Deals', value: '45', icon: Icons.handshake, subtitle: 'Closing Phase'),
        PrimeCareKpiCard(title: 'Pipeline Value', value: '\$5.4M', icon: Icons.monetization_on, subtitle: '+12% YOY'),
        PrimeCareKpiCard(title: 'Partnerships', value: '12', icon: Icons.business, subtitle: 'Active Contracts'),
        PrimeCareKpiCard(title: 'Win Rate', value: '68%', icon: Icons.emoji_events, subtitle: 'Top Tier'),
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
                          title: Text('Automated business Report Generation - Batch ${index + 1}'),
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
                      icon: Icon(Icons.settings, color: Theme.of(context).primaryColor),
                      label: Text('Module Configurations', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
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
