import 'package:flutter/material.dart';
import '../base_form.dart';

class ApproveExpenseReimbursementForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ApproveExpenseReimbursementForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ApproveExpenseReimbursementForm> createState() =>
      _ApproveExpenseReimbursementFormState();
}

class _ApproveExpenseReimbursementFormState
    extends State<ApproveExpenseReimbursementForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Approve Reimbursement',
      subtitle: 'Approve staff monetary reimbursement.',
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
