import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewCarePlanForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewCarePlanForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewCarePlanForm> createState() => _ReviewCarePlanFormState();
}

class _ReviewCarePlanFormState extends State<ReviewCarePlanForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Care Plan',
      subtitle: 'Modify or review the care plan.',
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
