import 'package:flutter/material.dart';
import '../base_form.dart';

class CreateAdPlacementForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const CreateAdPlacementForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CreateAdPlacementForm> createState() => _CreateAdPlacementFormState();
}

class _CreateAdPlacementFormState extends State<CreateAdPlacementForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Create Ad Placement',
      subtitle: 'Create hyper-local geo-fenced ad.',
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
