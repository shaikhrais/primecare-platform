import 'package:flutter/material.dart';
import '../base_form.dart';

class CreateSupplyOrderForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const CreateSupplyOrderForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CreateSupplyOrderForm> createState() => _CreateSupplyOrderFormState();
}

class _CreateSupplyOrderFormState extends State<CreateSupplyOrderForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Create Supply Order',
      subtitle: 'Order bulk operational supplies.',
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
