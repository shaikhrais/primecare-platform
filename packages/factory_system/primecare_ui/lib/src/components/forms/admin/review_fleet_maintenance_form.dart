import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewFleetMaintenanceForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewFleetMaintenanceForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewFleetMaintenanceForm> createState() =>
      _ReviewFleetMaintenanceFormState();
}

class _ReviewFleetMaintenanceFormState
    extends State<ReviewFleetMaintenanceForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Fleet Maintenance',
      subtitle: 'Audit operational vehicle fleets.',
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
