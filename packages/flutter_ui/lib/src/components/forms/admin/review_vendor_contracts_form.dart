import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewVendorContractsForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewVendorContractsForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewVendorContractsForm> createState() => _ReviewVendorContractsFormState();
}

class _ReviewVendorContractsFormState extends State<ReviewVendorContractsForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Vendor Contracts',
      subtitle: 'Audit third-party vendor SLAs.',
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
