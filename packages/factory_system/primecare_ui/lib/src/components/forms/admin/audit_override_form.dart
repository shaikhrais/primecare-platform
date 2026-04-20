import 'package:primecare_core/flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../layouts/responsive_grid_layout.dart';
import '../base_form.dart';
import 'audit_override_form_adapter.dart';

class AuditOverrideForm extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;

  const AuditOverrideForm({super.key, this.onSuccess});

  @override
  ConsumerState<AuditOverrideForm> createState() => _AuditOverrideFormState();
}

class _AuditOverrideFormState extends ConsumerState<AuditOverrideForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref.read(auditOverrideFormAdapterProvider.notifier).submit();
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Audit override request submitted successfully.')),
        );
        widget.onSuccess?.call();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(auditOverrideFormAdapterProvider);
    final theme = Theme.of(context);
    final layout = ref.watch(layoutProvider);

    final data = asyncState.value;

    return BaseForm(
      formKey: _formKey,
      title: 'Audit Override',
      subtitle: 'Override global audit configurations for specific compliance needs.',
      onSubmit: _submit,
      submitText: 'Request Override',
      isLoading: asyncState.isLoading,
      isEnabled: data != null && data.name.isNotEmpty && data.details.isNotEmpty,
      children: [
        if (asyncState.hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              asyncState.error.toString(),
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ResponsiveGridRow(
          spacing: (16 * layout.scaleFactor).toDouble(),
          runSpacing: (16 * layout.scaleFactor).toDouble(),
          children: [
            ResponsiveGridCol(
              span: layout.totalColumns,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Override Name',
                  hintText: 'e.g., Data Retention Extension',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular((12 * layout.scaleFactor).toDouble()),
                  ),
                ),
                key: ValueKey('name_${data?.name}'),
                initialValue: data?.name,
                onChanged: (val) => ref
                    .read(auditOverrideFormAdapterProvider.notifier)
                    .updateData(name: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
            ResponsiveGridCol(
              span: layout.totalColumns,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Override Details',
                  hintText: 'Describe why this override is necessary...',
                  labelStyle: TextStyle(color: theme.colorScheme.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular((12 * layout.scaleFactor).toDouble()),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                key: ValueKey('details_${data?.details}'),
                initialValue: data?.details,
                onChanged: (val) => ref
                    .read(auditOverrideFormAdapterProvider.notifier)
                    .updateData(details: val),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
