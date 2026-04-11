import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewLeadConversionForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewLeadConversionForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewLeadConversionForm> createState() =>
      _ReviewLeadConversionFormState();
}

class _ReviewLeadConversionFormState extends State<ReviewLeadConversionForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Lead Conversion Review',
      subtitle: 'Review and validate sales team conversions.',
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
