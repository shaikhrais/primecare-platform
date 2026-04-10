import 'package:flutter/material.dart';
import '../base_form.dart';

class FranchiseOnboardingChecklistForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const FranchiseOnboardingChecklistForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<FranchiseOnboardingChecklistForm> createState() => _FranchiseOnboardingChecklistFormState();
}

class _FranchiseOnboardingChecklistFormState extends State<FranchiseOnboardingChecklistForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Franchise Onboarding',
      subtitle: 'Complete franchise onboarding steps.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [
        const Text('Form fields go here...'),
      ],
    );
  }
}
