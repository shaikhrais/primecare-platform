import 'package:flutter/material.dart';
import '../base_form.dart';

class CreateCannedResponseForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const CreateCannedResponseForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CreateCannedResponseForm> createState() => _CreateCannedResponseFormState();
}

class _CreateCannedResponseFormState extends State<CreateCannedResponseForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Create Canned Response',
      subtitle: 'Add a new standardized support response.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [
        const Text('Form fields go here...'),
      ],
    );
  }
}
