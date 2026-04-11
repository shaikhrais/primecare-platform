import 'package:flutter/material.dart';
import '../base_form.dart';

class DisciplineLogForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const DisciplineLogForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<DisciplineLogForm> createState() => _DisciplineLogFormState();
}

class _DisciplineLogFormState extends State<DisciplineLogForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Discipline Log',
      subtitle: 'Record a disciplinary action or warning.',
      onSubmit: _submit,
      isLoading: widget.isLoading,
      children: [const Text('Form fields go here...')],
    );
  }
}
