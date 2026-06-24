/* 
PRIME:SCREEN=marketing_r_o_i_report
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
// Governance - Category: service | Purpose: Core implementation file for the Marketing Roi Report platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final marketingRoiProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/marketing/roi');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class MarketingROIReportScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for displaying marketing ROI data, buttons for refreshing and exporting data, and APIs for fetching campaign information.';

  @override
  List<String> get requiredComponents => const [
        'MarketingROIChart',
        'CampaignPerformanceTable',
        'SummaryStatisticsCard',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshData',
        'exportCampaignData',
        'analyzePerformance',
      ];

  const MarketingROIReportScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(marketingRoiProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Marketing ROI Report',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('marketing_roi_report_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(marketingRoiProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text('Export Campaign Data'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load marketing ROI data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (campaigns) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Campaign Performance & Conversion Rates', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    final campaign = campaigns[index];
                    final roi = campaign['roi'] as double;
                    final isPositive = roi >= 0;

                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(campaign['campaignName'] as String, style: theme.typography.h4),
                                const SizedBox(height: 4),
                                Text('Channel: ${campaign['channel']} | Spend: \$${campaign['spend']}', style: theme.typography.bodyMedium),
                                const SizedBox(height: 4),
                                Text('New Leads: ${campaign['leads']} | Conversions: ${campaign['conversions']}', style: theme.typography.labelSmall),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('ROI', style: theme.typography.labelSmall),
                                Text(
                                  '${isPositive ? '+' : ''}$roi%',
                                  style: theme.typography.h3.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }
}
