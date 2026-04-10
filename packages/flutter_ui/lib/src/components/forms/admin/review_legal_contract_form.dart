import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewLegalContractForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewLegalContractForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewLegalContractForm> createState() => _ReviewLegalContractFormState();
}

class _ReviewLegalContractFormState extends State<ReviewLegalContractForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Legal Contract',
      subtitle: 'Review partnership contract metrics.',
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
