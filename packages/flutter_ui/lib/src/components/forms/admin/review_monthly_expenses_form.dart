import 'package:flutter/material.dart';
import '../base_form.dart';

class ReviewMonthlyExpensesForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewMonthlyExpensesForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewMonthlyExpensesForm> createState() => _ReviewMonthlyExpensesFormState();
}

class _ReviewMonthlyExpensesFormState extends State<ReviewMonthlyExpensesForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    widget.onSubmit({});
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: 'Review Expenses',
      subtitle: 'Review franchise P&L statements.',
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
