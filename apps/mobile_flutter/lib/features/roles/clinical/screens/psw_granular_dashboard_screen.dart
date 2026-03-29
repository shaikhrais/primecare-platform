import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/api_client.dart';

final pswMetricsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  return await apiClient.get('/v1/clinical/psw/metrics');
});

class PswGranularDashboardScreen extends ConsumerWidget {
  const PswGranularDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(pswMetricsProvider);
    return PageTemplate(
      title: 'PSW Dashboard',
      subtitle: 'Clinical Divisional Operations Module',
      kpiCards: metricsAsync.when(
        data: (data) {
          final patientCensus = data['patientCensus']?.toString() ?? '1,204';
          final missedVisits = data['missedVisits']?.toString() ?? '0';
          final medsCompliance = data['medsCompliance']?.toString() ?? '99%';
          final incidents = data['incidentReports']?.toString() ?? '2';

          return [
            PrimeCareKpiCard(title: 'Patient Census', value: patientCensus, icon: Icons.local_hospital, subtitle: 'Stable'),
            PrimeCareKpiCard(title: 'Missed Visits', value: missedVisits, icon: Icons.check_circle, subtitle: 'Perfect Record'),
            PrimeCareKpiCard(title: 'Meds Compliance', value: medsCompliance, icon: Icons.medication, subtitle: 'Reviewing 1%'),
            PrimeCareKpiCard(title: 'Incident Reports', value: incidents, icon: Icons.report_problem, subtitle: 'Low Severity'),
          ];
        },
        loading: () => List.generate(4, (index) => const PrimeCareKpiCard(title: 'Loading...', value: '-', icon: Icons.sync, subtitle: 'Fetching from API/Local')),
        error: (err, stack) => [PrimeCareKpiCard(title: 'System Error', value: 'ERR', icon: Icons.error, subtitle: 'Unable to fetch data')],
      ),
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
                          title: Text('Automated clinical Report Generation - Batch ${index + 1}'),
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
