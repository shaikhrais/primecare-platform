import 'package:flutter/material.dart';
import '../base_form.dart';

class ScheduleInterviewForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ScheduleInterviewForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ScheduleInterviewForm> createState() => _ScheduleInterviewFormState();
}

class _ScheduleInterviewFormState extends State<ScheduleInterviewForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Schedule Interview',
      subtitle: 'Schedule candidate screening interview.',
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
