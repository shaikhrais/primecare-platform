import 'package:flutter/material.dart';
import '../base_form.dart';

class LogClinicalIncidentForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const LogClinicalIncidentForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<LogClinicalIncidentForm> createState() =>
      _LogClinicalIncidentFormState();
}

class _LogClinicalIncidentFormState extends State<LogClinicalIncidentForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Log Clinical Incident',
      subtitle: 'Report a new incident (fall, error).',
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
