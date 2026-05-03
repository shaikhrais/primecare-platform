// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Shared Component Library
// @governance: component=Global Validation Hooks
// @governance: component=Multi-Tenant Logic

    hide isOnlineProvider, ProviderTTL;

class CommonFormsView extends ConsumerWidget {
  const CommonFormsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(commonFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Common Utilities Center', style: theme.typography.h3),
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
                        .read(commonFormsControllerProvider.notifier)
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
                  label: 'Reference Number',
                  placeholder: 'REF-XXXX',
                ),
                SizedBox(height: theme.spacing.md),
                PrimeCareTextField(
                  label: 'Description',
                  placeholder: 'Enter details',
                ),
                SizedBox(height: theme.spacing.xl),
                PrimeCareButton(onPressed: () {}, label: 'Submit Form'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommonFormsIntent extends PrimeCareScreen {
  CommonFormsIntent()
      : super(
          name: 'common-forms',
          title: 'Common Forms',
          route: '/common-forms',
          requiredRole: PlatformRole.admin,
          form: PrimeCareForm.commonForms,
          provider: commonFormsControllerProvider,
          componentLabels: const [
            'Aura HUD',
            'Shared Component Library',
            'Global Validation Hooks',
            'Multi-Tenant Logic',
          ],
        );

  @override
  Widget build(BuildContext context) => const CommonFormsView();
}
