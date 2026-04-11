import 'package:flutter/material.dart';
import '../base_form.dart';

class ScheduleClinicalAuditForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ScheduleClinicalAuditForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ScheduleClinicalAuditForm> createState() =>
      _ScheduleClinicalAuditFormState();
}

class _ScheduleClinicalAuditFormState extends State<ScheduleClinicalAuditForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Schedule Clinical Audit',
      subtitle: 'Schedule internal/external compliance audit.',
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
