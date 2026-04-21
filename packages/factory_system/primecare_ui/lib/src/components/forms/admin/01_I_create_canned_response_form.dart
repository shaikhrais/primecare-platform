// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';

class CreateCannedResponseForm extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const CreateCannedResponseForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CreateCannedResponseForm> createState() =>
      _CreateCannedResponseFormState();
}

class _CreateCannedResponseFormState extends State<CreateCannedResponseForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit({'status': 'submitted', 'timestamp': DateTime.now().toIso8601String()});
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully tracked and submitted.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Create Canned Response',
      subtitle: 'Add a new standardized support response.',
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
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Details',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
                          ],
          ),
        ),
      ],
    );
  }
}
