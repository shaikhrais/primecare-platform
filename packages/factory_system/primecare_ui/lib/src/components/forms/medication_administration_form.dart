import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE

import 'package:primecare_ui/src/components/forms/base_form.dart';
import 'package:primecare_ui/src/components/forms/state/medication_administration_notifier.dart';

class MedicationAdministrationForm extends ConsumerStatefulWidget {
  final dynamic initialData;
  const MedicationAdministrationForm({super.key, this.initialData});

  @override
  ConsumerState<MedicationAdministrationForm> createState() =>
      _MedicationAdministrationFormState();
}

class _MedicationAdministrationFormState
    extends ConsumerState<MedicationAdministrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Use base form controllers list for disposal loop
  final List<TextEditingController> _controllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    if (widget.initialData is Map) {
      final data = widget.initialData as Map<String, dynamic>;
      _controllers[0].text = data['field1']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final payload = MedicationAdministrationPayload(
        data: {'field1': _controllers[0].text},
      );

      await ref.read(medicationAdministrationProvider.notifier).submit(payload);

      if (mounted && !ref.read(medicationAdministrationProvider).hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              LocaleKeys.dashboards_common_labels_successfully_submitted.tr(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(medicationAdministrationProvider);

    return BaseForm(
      title: LocaleKeys
          .dashboards_common_labels_medicationadministration_details
          .tr(),
      subtitle:
          'Complete the form to submit MedicationAdministration information.',
      isLoading: state.isLoading,
      formKey: _formKey,
      onSubmit: _submit,
      onCancel: () {
        _formKey.currentState?.reset();
        for (var c in _controllers) {
          c.clear();
        }
      },
      children: [
        ResponsiveGridRow(
          children: [
            // Row 1
            ResponsiveGridCol(
              span: 6,
              child: _buildTextField(
                controller: _controllers[0],
                label: 'Field 1',
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'common.status'.tr()),
                  items: [
                    DropdownMenuItem(
                      value: 'draft',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_draft.tr(),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'publish',
                      child: Text(
                        LocaleKeys.dashboards_common_labels_publish.tr(),
                      ),
                    ),
                  ],
                  onChanged: (v) {},
                  validator: (v) => v == null ? 'Required' : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }
}
