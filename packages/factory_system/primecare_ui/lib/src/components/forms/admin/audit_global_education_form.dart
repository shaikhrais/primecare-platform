import 'package:flutter/material.dart';
import '../base_form.dart';

class AuditGlobalEducationForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AuditGlobalEducationForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AuditGlobalEducationForm> createState() =>
      _AuditGlobalEducationFormState();
}

class _AuditGlobalEducationFormState extends State<AuditGlobalEducationForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Global Education Audit',
      subtitle: 'Audit global staff educational gaps.',
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
