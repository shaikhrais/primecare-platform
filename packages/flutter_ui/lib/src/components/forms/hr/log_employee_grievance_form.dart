import 'package:flutter/material.dart';
import '../base_form.dart';

class LogEmployeeGrievanceForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const LogEmployeeGrievanceForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<LogEmployeeGrievanceForm> createState() => _LogEmployeeGrievanceFormState();
}

class _LogEmployeeGrievanceFormState extends State<LogEmployeeGrievanceForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Log Employee Grievance',
      subtitle: 'Record a formal HR grievance/complaint.',
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
