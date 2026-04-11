import 'package:flutter/material.dart';
import '../base_form.dart';

class SubmitMarketingBudgetForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const SubmitMarketingBudgetForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<SubmitMarketingBudgetForm> createState() =>
      _SubmitMarketingBudgetFormState();
}

class _SubmitMarketingBudgetFormState extends State<SubmitMarketingBudgetForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Submit Marketing Budget',
      subtitle: 'Propose new regional ad spending limit.',
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
