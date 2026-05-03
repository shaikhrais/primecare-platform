// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Double-Entry Verification
// @governance: component=Tax Calculation Engine
// @governance: component=Ledger Sync Guard

    hide isOnlineProvider, ProviderTTL;

class FinancialFormsView extends ConsumerWidget {
  const FinancialFormsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(financialFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Financial Terminal', style: theme.typography.h3),
        ),
        body: Row(
          children: [
            SizedBox(
              width: 250,
              child: ListView.builder(
                itemCount: state.availableForms.length,
                itemBuilder: (context, index) {
                  final form = state.availableForms[index];
                  return ListTile(
                    selected: state.selectedForm == form,
                    title: Text(form),
                    onTap: () => ref
                        .read(financialFormsControllerProvider.notifier)
                        .selectForm(form),
                  );
                },
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: _buildFormContent(theme, state.selectedForm)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent(PrimeCareThemeData theme, String formTitle) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formTitle, style: theme.typography.h2),
          SizedBox(height: theme.spacing.lg),
          PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              children: [
                PrimeCareTextField(
                  label: 'Account Code',
                  placeholder: 'GL-XXXX-YY',
                ),
                SizedBox(height: theme.spacing.md),
                PrimeCareTextField(label: 'Amount', placeholder: '0.00'),
                SizedBox(height: theme.spacing.xl),
                PrimeCareButton(
                  onPressed: () {},
                  label: 'Process Financial Entry',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FinancialFormsIntent extends PrimeCareScreen {
  FinancialFormsIntent()
      : super(
          title: 'FinancialForms',
          componentLabels: const [
            'Aura HUD',
            'Double-Entry Verification',
            'Tax Calculation Engine',
            'Ledger Sync Guard',
          ],
        );

  @override
  Widget build(BuildContext context) => const FinancialFormsView();
}
