import 'package:flutter/material.dart';
import '../base_form.dart';

class ApprovePayrollRunForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ApprovePayrollRunForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ApprovePayrollRunForm> createState() => _ApprovePayrollRunFormState();
}

class _ApprovePayrollRunFormState extends State<ApprovePayrollRunForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Approve Payroll Run',
      subtitle: 'Approve mass corporate staff payroll.',
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
