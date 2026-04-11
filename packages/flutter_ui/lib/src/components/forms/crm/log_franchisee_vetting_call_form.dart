import 'package:flutter/material.dart';
import '../base_form.dart';

class LogFranchiseeVettingCallForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const LogFranchiseeVettingCallForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<LogFranchiseeVettingCallForm> createState() =>
      _LogFranchiseeVettingCallFormState();
}

class _LogFranchiseeVettingCallFormState
    extends State<LogFranchiseeVettingCallForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Log Vetting Call',
      subtitle: 'Record notes from initial lead vetting.',
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
