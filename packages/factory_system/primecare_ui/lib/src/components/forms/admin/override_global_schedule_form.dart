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
  State<OverrideGlobalScheduleForm> createState() =>
      _OverrideGlobalScheduleFormState();
}

class _OverrideGlobalScheduleFormState
    extends State<OverrideGlobalScheduleForm> {
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: const OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Details',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              // TODO: Integrate with active ViewModel/provider for structured submission
            ],
          ),
        ),
      ],
    );
  }
}
