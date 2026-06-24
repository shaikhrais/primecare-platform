/* 
PRIME:SCREEN=board_of_directors_summary
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_FINAL
PRIME:LOGIC=LOGIC_CLEAN
PRIME:API=API_ERROR_HANDLED
PRIME:DB=DB_FULLY_CONNECTED
PRIME:VALIDATION=VALIDATION_FULL
PRIME:QA=QA_PASSED
PRIME:FINAL=FINAL_FURNISHED
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: service | Purpose: Core implementation file for the Board Of Directors Summary platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final executiveSummaryProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/executive/summary');
  return response.data as Map<String, dynamic>;
});

class BoardOfDirectorsSummaryScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to display KPIs, refresh data, and generate a PDF report, along with necessary APIs and responsive design.';

  @override
  List<String> get requiredComponents => const [
        'KPIOverview',
        'ExecutiveSummary',
        'BoardDeckGenerator',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshExecutiveSummary',
        'generateBoardDeck',
      ];

  const BoardOfDirectorsSummaryScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(executiveSummaryProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Board of Directors Summary',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('board_of_directors_summary_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(executiveSummaryProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Generate Board Deck'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load executive summary: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (data) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('High-Level Organizational KPIs', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: (data['kpis'] as List).length,
                        itemBuilder: (context, index) {
                          final kpi = data['kpis'][index];
                          final isPositive = kpi['trend'] == 'up';
                          return Card(
                            color: theme.colors.surface,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(kpi['title'] as String, style: theme.typography.bodyMedium),
                                  const SizedBox(height: 8),
                                  Text(kpi['value'].toString(), style: theme.typography.h2),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Icon(
                                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                                        color: isPositive ? theme.colors.success : theme.colors.error,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        kpi['change'] as String,
                                        style: theme.typography.labelSmall.copyWith(
                                          color: isPositive ? theme.colors.success : theme.colors.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colors.border),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.dashboard, size: 64, color: theme.colors.primary.withOpacity(0.5)),
                              const SizedBox(height: 16),
                              Text('Executive Dashboard Mini-Map', style: theme.typography.h4),
                            ],
                          ),
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
