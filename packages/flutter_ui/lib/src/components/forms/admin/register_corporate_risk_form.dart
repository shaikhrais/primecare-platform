import 'package:flutter/material.dart';
import '../base_form.dart';

class RegisterCorporateRiskForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const RegisterCorporateRiskForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<RegisterCorporateRiskForm> createState() =>
      _RegisterCorporateRiskFormState();
}

class _RegisterCorporateRiskFormState extends State<RegisterCorporateRiskForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Register Corporate Risk',
      subtitle: 'Maintain institutional risk matrix.',
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
