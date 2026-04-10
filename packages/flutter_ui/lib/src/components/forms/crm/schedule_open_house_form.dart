import 'package:flutter/material.dart';
import '../base_form.dart';

class ScheduleOpenHouseForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ScheduleOpenHouseForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ScheduleOpenHouseForm> createState() => _ScheduleOpenHouseFormState();
}

class _ScheduleOpenHouseFormState extends State<ScheduleOpenHouseForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Schedule Open House',
      subtitle: 'Schedule regional franchise discovery day.',
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
