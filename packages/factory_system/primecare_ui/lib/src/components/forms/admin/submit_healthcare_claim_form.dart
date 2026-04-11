import 'package:flutter/material.dart';
import '../base_form.dart';

class SubmitHealthcareClaimForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const SubmitHealthcareClaimForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<SubmitHealthcareClaimForm> createState() =>
      _SubmitHealthcareClaimFormState();
}

class _SubmitHealthcareClaimFormState extends State<SubmitHealthcareClaimForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Submit Healthcare Claim',
      subtitle: 'Submit tracking for gov/insurance claim.',
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
