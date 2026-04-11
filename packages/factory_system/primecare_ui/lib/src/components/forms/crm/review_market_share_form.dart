import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewMarketShareForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewMarketShareForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewMarketShareForm> createState() => _ReviewMarketShareFormState();
}

class _ReviewMarketShareFormState extends State<ReviewMarketShareForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Market Share',
      subtitle: 'Review high-level geographic growth metrics.',
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
