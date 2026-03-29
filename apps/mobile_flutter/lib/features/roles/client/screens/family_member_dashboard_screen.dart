import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/master/shared/widgets/page_template.dart';

class FamilyMemberDashboardScreen extends StatelessWidget {
  const FamilyMemberDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Family Member Dashboard',
      subtitle: 'Client Divisional Operations Module',
      kpiCards: [
        PrimeCareKpiCard(title: 'Care Visits', value: '5', icon: Icons.calendar_today, subtitle: 'This Week'),
        PrimeCareKpiCard(title: 'Outstanding Bal', value: '\$0.00', icon: Icons.account_balance_wallet, subtitle: 'Paid in Full'),
        PrimeCareKpiCard(title: 'Caregiver Rating', value: '5.0', icon: Icons.star, subtitle: 'Exceptional'),
        PrimeCareKpiCard(title: 'New Messages', value: '1', icon: Icons.mail, subtitle: 'Review'),
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
                          title: Text('Automated client Report Generation - Batch ${index + 1}'),
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
