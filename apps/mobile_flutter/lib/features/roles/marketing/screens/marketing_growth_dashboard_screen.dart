import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/master/shared/widgets/page_template.dart';

class MarketingGrowthDashboardScreen extends StatelessWidget {
  const MarketingGrowthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Marketing and Local Growth Dashboard',
      subtitle: 'Marketing Divisional Operations Module',
      kpiCards: [
        PrimeCareKpiCard(title: 'Active Campaigns', value: '12', icon: Icons.campaign, subtitle: '+3 this week'),
        PrimeCareKpiCard(title: 'New Leads', value: '342', icon: Icons.group_add, subtitle: '⬆️ 14%'),
        PrimeCareKpiCard(title: 'Conversion Rate', value: '4.2%', icon: Icons.trending_up, subtitle: 'Above Target'),
        PrimeCareKpiCard(title: 'CAC', value: '\$42', icon: Icons.attach_money, subtitle: 'Optimal'),
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
                          title: Text('Automated marketing Report Generation - Batch ${index + 1}'),
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
