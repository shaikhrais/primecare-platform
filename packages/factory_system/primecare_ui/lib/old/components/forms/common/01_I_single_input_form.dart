// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';

class SingleInputForm extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String inputLabel;
  final String? initialValue;
  final bool isNumeric;
  final void Function(String) onSubmit;
  final VoidCallback? onCancel;
  final bool isLoading;

  const SingleInputForm({
    super.key,
    required this.title,
    this.subtitle,
    required this.inputLabel,
    this.initialValue,
    this.isNumeric = false,
    required this.onSubmit,
    this.onCancel,
    this.isLoading = false,
  });

  @override
  State<SingleInputForm> createState() => _SingleInputFormState();
}

class _SingleInputFormState extends State<SingleInputForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: widget.title,
      subtitle: widget.subtitle,
      isLoading: widget.isLoading,
      onCancel: widget.onCancel,
      onSubmit: () {
        widget.onSubmit(_controller.text);
      },
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: widget.inputLabel,
            border: const OutlineInputBorder(),
          ),
          keyboardType: widget.isNumeric
              ? TextInputType.number
              : TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            if (widget.isNumeric) {
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.

// Styled with global Theme and CustomColors.
