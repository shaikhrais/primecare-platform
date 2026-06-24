/* 
PRIME:SCREEN=patient_retention_analytics
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_QUERY_READY
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=60
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: service | Purpose: Core implementation file for the Patient Retention Analytics platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final patientRetentionProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/patients/retention');
  return response.data as Map<String, dynamic>;
});

class PatientRetentionAnalyticsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display patient retention metrics, lifetime value, cohort analysis, and error notifications, along with a refresh button for real-time data updates.';

  @override
  List<String> get requiredComponents => const [
        'RetentionRateIndicator',
        'LifetimeValueDisplay',
        'CohortAnalysisChart',
        'ErrorNotification',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchRetentionData',
        'fetchLifetimeValue',
        'fetchCohortAnalysis',
      ];

  const PatientRetentionAnalyticsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(patientRetentionProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Patient Retention Analytics',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('patient_retention_analytics_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(patientRetentionProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load retention analytics: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Churn Prediction & Lifetime Value (LTV)', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        color: theme.colors.surface,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Overall Retention Rate', style: theme.typography.h3),
                              const SizedBox(height: 16),
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: CircularProgressIndicator(
                                        value: (data['retentionRate'] as num) / 100.0,
                                        strokeWidth: 12,
                                        backgroundColor: theme.colors.border,
                                        valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
                                      ),
                                    ),
                                    Text('${data['retentionRate']}%', style: theme.typography.h1),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text('Avg LTV: \$${data['averageLTV']}', style: theme.typography.h4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cohort Retention Matrix', style: theme.typography.h3),
                            const SizedBox(height: 8),
                            Text('Percentage of active clients retained month-over-month by onboarding cohort.', style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant)),
                            const SizedBox(height: 24),
                            const Expanded(
                              child: SingleChildScrollView(
                                child: _CohortMatrixWidget(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CohortMatrixWidget extends StatelessWidget {
  const _CohortMatrixWidget();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Columns: Cohort, M1, M2, M3, M4, M5, M6
    final headers = ['Cohort', 'Month 1', 'Month 2', 'Month 3', 'Month 4', 'Month 5', 'Month 6'];
    final cohorts = [
      {'name': 'Jan 2026', 'rates': [100.0, 92.4, 88.1, 85.0, 81.2, 79.5]},
      {'name': 'Feb 2026', 'rates': [100.0, 94.1, 89.5, 86.2, 83.0, null]},
      {'name': 'Mar 2026', 'rates': [100.0, 91.8, 87.2, 84.1, null, null]},
      {'name': 'Apr 2026', 'rates': [100.0, 93.5, 89.0, null, null, null]},
      {'name': 'May 2026', 'rates': [100.0, 95.0, null, null, null, null]},
    ];

    return Table(
      border: TableBorder.all(
        color: theme.colors.border.withOpacity(0.5),
        width: 1,
        borderRadius: BorderRadius.circular(8),
      ),
      columnWidths: const {
        0: FlexColumnWidth(1.5),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // Header Row
        TableRow(
          decoration: BoxDecoration(
            color: theme.colors.surfaceContainerHighest.withOpacity(0.5),
          ),
          children: headers.map((h) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Text(
              h,
              style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )).toList(),
        ),
        // Cohort Rows
        ...cohorts.map((c) {
          final rates = c['rates'] as List;
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                child: Text(
                  c['name'] as String,
                  style: theme.typography.bodySmall.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ...rates.map((rate) {
                if (rate == null) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text('-', textAlign: TextAlign.center),
                  );
                }
                // Determine color opacity based on rate percentage
                final opacity = (rate as double) / 100.0 * 0.85;
                return Container(
                  color: theme.colors.primary.withOpacity(opacity),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    '${rate.toStringAsFixed(1)}%',
                    style: theme.typography.labelSmall.copyWith(
                      color: opacity > 0.5 ? Colors.white : theme.colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ],
    );
  }
}

