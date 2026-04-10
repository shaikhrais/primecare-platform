import 'package:flutter/material.dart';
import '../base_form.dart';

class ApproveSystemAccessForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ApproveSystemAccessForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ApproveSystemAccessForm> createState() => _ApproveSystemAccessFormState();
}

class _ApproveSystemAccessFormState extends State<ApproveSystemAccessForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Approve System Access',
      subtitle: 'Approve elevated permission requests.',
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
