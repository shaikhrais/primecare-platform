import 'package:flutter/material.dart';
import '../base_form.dart';

class CarePlanEvaluationForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const CarePlanEvaluationForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CarePlanEvaluationForm> createState() => _CarePlanEvaluationFormState();
}

class _CarePlanEvaluationFormState extends State<CarePlanEvaluationForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Care Plan Evaluation',
      subtitle: 'Evaluate and modify the care plan.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [const Text('Form fields go here...')],
    );
  }
}
