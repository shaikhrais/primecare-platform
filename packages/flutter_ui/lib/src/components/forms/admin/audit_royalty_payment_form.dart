import 'package:flutter/material.dart';
import '../base_form.dart';

class AuditRoyaltyPaymentForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AuditRoyaltyPaymentForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AuditRoyaltyPaymentForm> createState() =>
      _AuditRoyaltyPaymentFormState();
}

class _AuditRoyaltyPaymentFormState extends State<AuditRoyaltyPaymentForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Audit Royalty Payments',
      subtitle: 'Review aggregated royalty discrepancies.',
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
