import 'package:flutter/material.dart';
import '../base_form.dart';

class ApproveRealEstateForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ApproveRealEstateForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ApproveRealEstateForm> createState() => _ApproveRealEstateFormState();
}

class _ApproveRealEstateFormState extends State<ApproveRealEstateForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Approve Real Estate',
      subtitle: 'Approve physical branch location.',
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
