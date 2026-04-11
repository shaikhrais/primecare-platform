import 'package:flutter/material.dart';
import '../base_form.dart';

class NurtureLocalizedLeadForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const NurtureLocalizedLeadForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<NurtureLocalizedLeadForm> createState() =>
      _NurtureLocalizedLeadFormState();
}

class _NurtureLocalizedLeadFormState extends State<NurtureLocalizedLeadForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Nurture Localized Lead',
      subtitle: 'Categorize unassigned prospective lead.',
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
