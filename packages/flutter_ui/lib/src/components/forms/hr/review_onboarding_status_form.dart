import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewOnboardingStatusForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewOnboardingStatusForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewOnboardingStatusForm> createState() =>
      _ReviewOnboardingStatusFormState();
}

class _ReviewOnboardingStatusFormState
    extends State<ReviewOnboardingStatusForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Onboarding Status',
      subtitle: 'Review status of pending new hires.',
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
