import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewPeerPerformanceForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewPeerPerformanceForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewPeerPerformanceForm> createState() => _ReviewPeerPerformanceFormState();
}

class _ReviewPeerPerformanceFormState extends State<ReviewPeerPerformanceForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Peer Performance',
      subtitle: 'Analyze peer review assessments.',
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
