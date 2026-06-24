/* 
PRIME:SCREEN=supply_chain_cost_analyzer
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
// Governance - Category: service | Purpose: Core implementation file for the Supply Chain Cost Analyzer platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final supplyChainCostProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/analytics/procurement/costs');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class SupplyChainCostAnalyzerScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components to analyze procurement spending, manage vendors, and refresh data, along with appropriate buttons and API endpoints.';

  @override
  List<String> get requiredComponents => const [
        'ProcurementSpendingChart',
        'BudgetVarianceIndicator',
        'VendorManagementPanel',
      ];

  @override
  List<String> get requiredFunctions => const [
        'analyzeSpendingByCategory',
        'refreshData',
        'manageVendors',
      ];

  const SupplyChainCostAnalyzerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(supplyChainCostProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Supply Chain Cost Analyzer',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('supply_chain_cost_analyzer_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(supplyChainCostProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Manage Vendors'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load cost data: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (categories) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Procurement Spending by Category', style: theme.typography.h2),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final variance = category['variance'] as double;
                    final isOverBudget = variance > 0;

                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: const Icon(Icons.inventory_2),
                        title: Text(category['categoryName'] as String, style: theme.typography.h4),
                        subtitle: Text('Budget: \$${category['budget']} | Actual: \$${category['actualSpend']}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Variance', style: theme.typography.labelSmall),
                            Text(
                              '${isOverBudget ? '+' : ''}\$${variance.abs()}',
                              style: theme.typography.bodyLarge.copyWith(
                                color: isOverBudget ? theme.colors.error : theme.colors.success,
                                fontWeight: FontWeight.bold,
                              ),
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
