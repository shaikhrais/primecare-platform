import 'package:flutter/material.dart';
import '../base_form.dart';

class ApproveSystemAccessForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ApproveSystemAccessForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ApproveSystemAccessForm> createState() =>
      _ApproveSystemAccessFormState();
}

class _ApproveSystemAccessFormState extends State<ApproveSystemAccessForm> {
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
      title: 'Approve System Access',
      subtitle: 'Approve elevated permission requests.',
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
