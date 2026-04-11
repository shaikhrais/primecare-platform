import 'package:flutter/material.dart';
import '../base_form.dart';

class SubmitDailyCensusForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const SubmitDailyCensusForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<SubmitDailyCensusForm> createState() => _SubmitDailyCensusFormState();
}

class _SubmitDailyCensusFormState extends State<SubmitDailyCensusForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Submit Daily Census',
      subtitle: 'Submit location-based bed/patient census.',
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
