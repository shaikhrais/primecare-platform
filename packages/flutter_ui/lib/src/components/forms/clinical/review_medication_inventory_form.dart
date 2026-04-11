import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewMedicationInventoryForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewMedicationInventoryForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewMedicationInventoryForm> createState() =>
      _ReviewMedicationInventoryFormState();
}

class _ReviewMedicationInventoryFormState
    extends State<ReviewMedicationInventoryForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Med Inventory',
      subtitle: 'Audit controlled medication distribution logs.',
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
