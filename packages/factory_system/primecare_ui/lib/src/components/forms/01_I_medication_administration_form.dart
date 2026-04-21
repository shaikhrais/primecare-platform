// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/components/layouts/01_I_responsive_grid_layout.dart';

import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';
import 'package:primecare_ui/src/components/forms/state/01_I_medication_administration_notifier.dart';

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Successfully submitted')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(medicationAdministrationProvider);

    return BaseForm(
      title: 'MedicationAdministration Details',
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
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(value: 'draft', child: Text('Draft')),
                    DropdownMenuItem(value: 'publish', child: Text('Publish')),
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
