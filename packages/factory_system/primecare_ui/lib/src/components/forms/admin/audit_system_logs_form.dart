import 'package:flutter/material.dart';
import '../base_form.dart';

class AuditSystemLogsForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AuditSystemLogsForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AuditSystemLogsForm> createState() => _AuditSystemLogsFormState();
}

class _AuditSystemLogsFormState extends State<AuditSystemLogsForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Audit System Logs',
      subtitle: 'Review sensitive access control logs.',
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
