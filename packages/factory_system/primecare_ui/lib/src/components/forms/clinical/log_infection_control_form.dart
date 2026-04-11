import 'package:flutter/material.dart';
import '../base_form.dart';

class LogInfectionControlForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const LogInfectionControlForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<LogInfectionControlForm> createState() =>
      _LogInfectionControlFormState();
}

class _LogInfectionControlFormState extends State<LogInfectionControlForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Log Infection Control',
      subtitle: 'Report localized infection outbreak.',
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
