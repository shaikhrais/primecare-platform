// Governance - Category: service | Purpose: Core implementation file for the Certification Renewal Alerts platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final certAlertsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/certs/alerts');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class CertificationRenewalAlertsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to monitor and manage certification renewal alerts, including functionalities for sending reminders and refreshing the alert list.';

  @override
  List<String> get requiredComponents => const [
        'CertificationAlertList',
        'CertificationOverviewCard',
        'CertificationStatusBreakdown',
        'ReminderButton',
        'NotificationSystem',
        'PerformanceMetrics',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadAlerts',
        'sendCriticalReminders',
        'refreshAlertList',
      ];

  const CertificationRenewalAlertsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(certAlertsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Certification Renewal Alerts', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('certification_renewal_alerts_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(certAlertsProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (alerts) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Expiring Certifications & Licenses', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: alerts.length,
                  itemBuilder: (context, index) {
                    final alert = alerts[index];
                    final bool isCritical = (alert['days_remaining'] as num) < 30;
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: isCritical ? Colors.red : Colors.transparent, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.warning_amber_rounded, color: isCritical ? Colors.red : Colors.orange, size: 32),
                        title: Text(alert['provider_name'] as String, style: theme.typography.h4),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text('${alert['certification_type']} | ID: ${alert['license_number']}', style: theme.typography.bodyMedium),
                            Text('Expires: ${alert['expiry_date']}', style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold, color: isCritical ? Colors.red : Colors.orange)),
                          ],
                        ),
                        trailing: ElevatedButton(key: const Key('certification_renewal_alerts_elevatedbutton_button_1'), 
                          style: ElevatedButton.styleFrom(backgroundColor: isCritical ? Colors.red : theme.colors.primary),
                          onPressed: () {},
                          child: const Text('Send Reminder'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
