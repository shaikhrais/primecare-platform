import 'package:flutter/material.dart';
import '../base_form.dart';

class AuditComplianceForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AuditComplianceForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AuditComplianceForm> createState() => _AuditComplianceFormState();
}

class _AuditComplianceFormState extends State<AuditComplianceForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Compliance Audit',
      subtitle: 'Audit federal compliance rules.',
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
