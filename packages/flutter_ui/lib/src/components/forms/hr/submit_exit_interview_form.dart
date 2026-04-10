import 'package:flutter/material.dart';
import '../base_form.dart';

class SubmitExitInterviewForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const SubmitExitInterviewForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<SubmitExitInterviewForm> createState() => _SubmitExitInterviewFormState();
}

class _SubmitExitInterviewFormState extends State<SubmitExitInterviewForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Submit Exit Interview',
      subtitle: 'Record exit interview results.',
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
