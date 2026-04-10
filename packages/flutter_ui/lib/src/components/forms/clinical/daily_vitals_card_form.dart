import 'package:flutter/material.dart';
import '../base_form.dart';

class DailyVitalsCardForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const DailyVitalsCardForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<DailyVitalsCardForm> createState() => _DailyVitalsCardFormState();
}

class _DailyVitalsCardFormState extends State<DailyVitalsCardForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Daily Vitals',
      subtitle: 'Log patient daily vitals.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [
        const Text('Form fields go here...'),
      ],
    );
  }
}
