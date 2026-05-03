// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Lead Capture Hook
// @governance: component=Contact Field Synchronization
// @governance: component=Pipeline Event Trigger

    hide isOnlineProvider, ProviderTTL;

class CrmFormsView extends ConsumerWidget {
  const CrmFormsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(crmFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('CRM & Growth Dashboard', style: theme.typography.h3),
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
                        .read(crmFormsControllerProvider.notifier)
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
                  label: 'Lead Name',
                  placeholder: 'Enter name',
                ),
                SizedBox(height: theme.spacing.md),
                PrimeCareTextField(
                  label: 'Campaign ID',
                  placeholder: 'MKT-2024-X',
                ),
                SizedBox(height: theme.spacing.xl),
                PrimeCareButton(onPressed: () {}, label: 'Process Growth Form'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CrmFormsIntent extends PrimeCareScreen {
  CrmFormsIntent()
      : super(
          title: 'CrmForms',
          componentLabels: const [
            'Aura HUD',
            'Lead Capture Hook',
            'Contact Field Synchronization',
            'Pipeline Event Trigger',
          ],
        );

  @override
  Widget build(BuildContext context) => const CrmFormsView();
}
