import 'package:flutter/material.dart';
import '../base_form.dart';

class SubmitAdlChecklistForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const SubmitAdlChecklistForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<SubmitAdlChecklistForm> createState() => _SubmitAdlChecklistFormState();
}

class _SubmitAdlChecklistFormState extends State<SubmitAdlChecklistForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Submit ADL Checklist',
      subtitle: 'Submit Activities of Daily Living checklist.',
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
