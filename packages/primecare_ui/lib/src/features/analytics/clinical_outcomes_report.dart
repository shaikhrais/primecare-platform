/* 
PRIME:SCREEN=clinical_outcomes_report
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
// Governance - Category: service | Purpose: Core implementation file for the Clinical Outcomes Report platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final clinicalOutcomesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/clinical/outcomes');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class ClinicalOutcomesReportScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display clinical outcomes data, buttons for refreshing and exporting the report, and functions to handle data loading and exporting.';

  @override
  List<String> get requiredComponents => const [
        'ClinicalOutcomesTable',
        'SuccessRateIndicator',
        'ErrorMessageDisplay',
      ];

  @override
  List<String> get requiredFunctions => const [
        'loadClinicalOutcomes',
        'refreshData',
        'exportReport',
      ];

  const ClinicalOutcomesReportScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clinicalOutcomesProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Clinical Outcomes Report',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('clinical_outcomes_report_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(clinicalOutcomesProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Export PDF'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load clinical outcomes: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (outcomes) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Treatment Success Rates & Benchmarks', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: outcomes.length,
                  itemBuilder: (context, index) {
                    final outcome = outcomes[index];
                    final successRate = outcome['successRate'] as double;
                    final isAboveBenchmark = successRate >= (outcome['benchmark'] as double);

                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(outcome['department'] as String? ?? 'Unknown Department', style: theme.typography.h4),
                                Chip(
                                  label: Text('${(successRate * 100).toStringAsFixed(1)}% Success Rate'),
                                  backgroundColor: isAboveBenchmark ? theme.colors.success.withOpacity(0.2) : theme.colors.error.withOpacity(0.2),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: successRate,
                              backgroundColor: theme.colors.border,
                              valueColor: AlwaysStoppedAnimation<Color>(isAboveBenchmark ? theme.colors.success : theme.colors.error),
                            ),
                            const SizedBox(height: 8),
                            Text('Benchmark: ${(outcome['benchmark'] * 100).toStringAsFixed(1)}%', style: theme.typography.labelSmall),
                          ],
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
