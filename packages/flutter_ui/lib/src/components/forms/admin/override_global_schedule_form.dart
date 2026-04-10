import 'package:flutter/material.dart';
import '../base_form.dart';

class OverrideGlobalScheduleForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const OverrideGlobalScheduleForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<OverrideGlobalScheduleForm> createState() => _OverrideGlobalScheduleFormState();
}

class _OverrideGlobalScheduleFormState extends State<OverrideGlobalScheduleForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Override Global Schedule',
      subtitle: 'Force-publish global branch schedules.',
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
