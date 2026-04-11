import 'package:flutter/material.dart';
import '../base_form.dart';

class ApproveMedicationRefillForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ApproveMedicationRefillForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ApproveMedicationRefillForm> createState() =>
      _ApproveMedicationRefillFormState();
}

class _ApproveMedicationRefillFormState
    extends State<ApproveMedicationRefillForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Approve Med Refill',
      subtitle: 'Physician approval for prescription refill.',
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
