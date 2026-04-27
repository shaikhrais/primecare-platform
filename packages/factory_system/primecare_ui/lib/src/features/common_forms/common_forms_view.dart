import 'package:primecare_ui/primecare_ui.dart';
import 'common_forms_controller.dart';
import 'common_forms_model.dart';

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
                    onTap: () => ref.read(commonFormsControllerProvider.notifier).selectForm(form),
                  );
                },
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: _buildFormContent(theme, state.selectedForm),
            ),
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
                PrimeCareTextField(label: 'Reference Number', placeholder: 'REF-XXXX'),
                SizedBox(height: theme.spacing.md),
                PrimeCareTextField(label: 'Description', placeholder: 'Enter details'),
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
  CommonFormsIntent() : super(title: "CommonForms");

  @override
  Widget build(BuildContext context) => const CommonFormsView();
}


