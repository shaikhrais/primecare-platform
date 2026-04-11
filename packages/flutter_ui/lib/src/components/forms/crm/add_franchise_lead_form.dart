import 'package:flutter/material.dart';
import '../base_form.dart';

class AddFranchiseLeadForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AddFranchiseLeadForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AddFranchiseLeadForm> createState() => _AddFranchiseLeadFormState();
}

class _AddFranchiseLeadFormState extends State<AddFranchiseLeadForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Add Franchise Lead',
      subtitle: 'Register a new potential franchise lead.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [const Text('Form fields go here...')],
    );
  }
}
