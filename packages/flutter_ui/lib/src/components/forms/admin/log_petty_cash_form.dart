import 'package:flutter/material.dart';
import '../base_form.dart';

class LogPettyCashForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const LogPettyCashForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<LogPettyCashForm> createState() => _LogPettyCashFormState();
}

class _LogPettyCashFormState extends State<LogPettyCashForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Log Petty Cash',
      subtitle: 'Record localized petty cash expenditure.',
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
