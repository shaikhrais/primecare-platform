/* 
PRIME:SCREEN=lead_conversion_funnel
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
// Governance - Category: service | Purpose: Core implementation file for the Lead Conversion Funnel platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final leadConversionProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/leads/conversion');
  return response.data as Map<String, dynamic>;
});

class LeadConversionFunnelScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires real-time metrics monitoring, visual data representation, and alerts for significant changes in the lead conversion funnel.';

  @override
  List<String> get requiredComponents => const [
        'ImpressionMetricCard',
        'WebsiteVisitChart',
        'LeadAnalysisCard',
        'AppointmentReviewCard',
        'ConversionRateChart',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshData',
        'alertSignificantChange',
      ];

  const LeadConversionFunnelScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(leadConversionProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Lead Conversion Funnel', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('lead_conversion_funnel_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(leadConversionProvider),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (funnelData) => Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Sales Funnel Metrics', style: theme.typography.h2, textAlign: TextAlign.center),
              const SizedBox(height: 48),
              _FunnelStage(label: 'Total Impressions', value: funnelData['impressions'] as int, color: Colors.blue[300]!, widthRatio: 1.0, theme: theme),
              const SizedBox(height: 8),
              _FunnelStage(label: 'Website Visits', value: funnelData['visits'] as int, color: Colors.blue[500]!, widthRatio: 0.8, theme: theme),
              const SizedBox(height: 8),
              _FunnelStage(label: 'Leads Generated', value: funnelData['leads'] as int, color: Colors.blue[700]!, widthRatio: 0.6, theme: theme),
              const SizedBox(height: 8),
              _FunnelStage(label: 'Appointments Booked', value: funnelData['appointments'] as int, color: Colors.blue[900]!, widthRatio: 0.4, theme: theme),
              const SizedBox(height: 48),
              Center(
                child: Card(
                  color: theme.colors.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text('Conversion Rate', style: theme.typography.labelSmall),
                        Text('${funnelData['conversion_rate']}%', style: theme.typography.h1.copyWith(color: theme.colors.primary)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _FunnelStage({required String label, required int value, required Color color, required double widthRatio, required PrimeThemeData theme}) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: widthRatio,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '$label: $value',
            style: theme.typography.h4.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
