import 'package:flutter/material.dart';
import '../base_form.dart';

class ApproveLeaveRequestForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ApproveLeaveRequestForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ApproveLeaveRequestForm> createState() => _ApproveLeaveRequestFormState();
}

class _ApproveLeaveRequestFormState extends State<ApproveLeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Approve Leave Request',
      subtitle: 'Manager approval for time-off.',
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
