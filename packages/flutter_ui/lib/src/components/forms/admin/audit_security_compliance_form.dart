import 'package:flutter/material.dart';
import '../base_form.dart';

class AuditSecurityComplianceForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AuditSecurityComplianceForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AuditSecurityComplianceForm> createState() =>
      _AuditSecurityComplianceFormState();
}

class _AuditSecurityComplianceFormState
    extends State<AuditSecurityComplianceForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Security Compliance Audit',
      subtitle: 'Review SOC2 compliance checklists.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text('Form fields go here...'),
        ),
      ],
    );
  }
}
