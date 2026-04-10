import 'package:flutter/material.dart';
import '../base_form.dart';

class AuditOverrideForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AuditOverrideForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AuditOverrideForm> createState() => _AuditOverrideFormState();
}

class _AuditOverrideFormState extends State<AuditOverrideForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Audit Override',
      subtitle: 'Override global audit configurations.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [
        const Text('Form fields go here...'),
      ],
    );
  }
}
