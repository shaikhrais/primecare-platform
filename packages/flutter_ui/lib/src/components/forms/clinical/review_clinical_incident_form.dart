import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewClinicalIncidentForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewClinicalIncidentForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewClinicalIncidentForm> createState() =>
      _ReviewClinicalIncidentFormState();
}

class _ReviewClinicalIncidentFormState
    extends State<ReviewClinicalIncidentForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Incident',
      subtitle: 'Review and resolve reported clinical incidents.',
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
