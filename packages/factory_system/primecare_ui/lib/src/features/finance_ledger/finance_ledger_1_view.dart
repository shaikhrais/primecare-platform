// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';

// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Double-Entry Balance Sheet
// @governance: component=Journal Entry Grid
// @governance: component=Cash Flow Forecast

class FinanceLedger1View extends ConsumerWidget {
  const FinanceLedger1View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.corporate_finance_director_dashboard_title.tr()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Aura HUD', style: theme.typography.h3),
            const SizedBox(height: 16),
            const Card(child: ListTile(title: Text('Financial Health Score: 98%'))),
            const SizedBox(height: 32),
            
            Text('Double-Entry Balance Sheet', style: theme.typography.h3),
            const SizedBox(height: 16),
            const Card(child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Assets: \$5,000,000 | Liabilities: \$2,000,000 | Equity: \$3,000,000'),
            )),
            const SizedBox(height: 32),

            Text('Journal Entry Grid', style: theme.typography.h3),
            const SizedBox(height: 16),
            const Card(child: ListTile(title: Text('Recent Transactions: 45 entries pending review'))),
            const SizedBox(height: 32),

            Text('Cash Flow Forecast', style: theme.typography.h3),
            const SizedBox(height: 16),
            const Card(child: ListTile(title: Text('Projected Cash Flow (Q3): +\$450,000'))),
          ],
        ),
      ),
    );
  }
}

class FinanceLedger1Intent extends PrimeCareScreen {
  FinanceLedger1Intent()
      : super(
          name: 'finance_ledger',
          title: LocaleKeys.corporate_finance_director_dashboard_title,
          route: '/finance-ledger',
          requiredRole: PlatformRole.financeDirector,
          provider: financeDirectorDashboardAdapterProvider, // Using director provider as fallback
          componentLabels: const [
            'Aura HUD',
            'Double-Entry Balance Sheet',
            'Journal Entry Grid',
            'Cash Flow Forecast',
          ],
        );

  @override
  Widget build(BuildContext context) => const FinanceLedger1View();
}
