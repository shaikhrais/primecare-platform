import 'package:flutter/material.dart';
import '../base_form.dart';

class PatientIntakeForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const PatientIntakeForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<PatientIntakeForm> createState() => _PatientIntakeFormState();
}

class _PatientIntakeFormState extends State<PatientIntakeForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Patient Intake',
      subtitle: 'Initial patient intake assessment.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [
        const Text('Form fields go here...'),
      ],
    );
  }
}
