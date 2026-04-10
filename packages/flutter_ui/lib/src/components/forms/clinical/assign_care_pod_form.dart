import 'package:flutter/material.dart';
import '../base_form.dart';

class AssignCarePodForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AssignCarePodForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AssignCarePodForm> createState() => _AssignCarePodFormState();
}

class _AssignCarePodFormState extends State<AssignCarePodForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Assign Care Pod',
      subtitle: 'Assign client to primary care nursing pod.',
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
