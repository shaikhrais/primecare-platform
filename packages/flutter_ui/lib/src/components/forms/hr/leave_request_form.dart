import 'package:flutter/material.dart';
import '../base_form.dart';

class LeaveRequestForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const LeaveRequestForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Leave Request',
      subtitle: 'Submit an employee leave request.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [const Text('Form fields go here...')],
    );
  }
}
