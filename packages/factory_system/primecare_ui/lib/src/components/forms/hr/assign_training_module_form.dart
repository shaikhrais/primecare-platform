import 'package:flutter/material.dart';
import '../base_form.dart';

class AssignTrainingModuleForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AssignTrainingModuleForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AssignTrainingModuleForm> createState() =>
      _AssignTrainingModuleFormState();
}

class _AssignTrainingModuleFormState extends State<AssignTrainingModuleForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Assign Training Module',
      subtitle: 'Enroll staff into required LMS modules.',
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
