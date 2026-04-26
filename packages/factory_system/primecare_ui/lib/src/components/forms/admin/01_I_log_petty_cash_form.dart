import 'package:easy_localization/easy_localization.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';
import 'package:primecare_ui/src/components/forms/admin/01_I_log_petty_cash_form_adapter.dart';

class LogPettyCashForm extends ConsumerStatefulWidget {
  const LogPettyCashForm({super.key});

  @override
  ConsumerState<LogPettyCashForm> createState() => _LogPettyCashFormState();
}

class _LogPettyCashFormState extends ConsumerState<LogPettyCashForm> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _merchantController = TextEditingController();
  final _detailsController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = '6100'; // Office Supplies

  final List<Map<String, String>> _categories = [
    {'code': '6100', 'name': 'Office Supplies'},
    {'code': '6200', 'name': 'Travel & Meals'},
    {'code': '6300', 'name': 'Maintenance & Repairs'},
    {'code': '6000', 'name': 'General Operating'},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _merchantController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final adapter = ref.read(logPettyCashFormAdapterProvider.notifier);
      final success = await adapter.submit(
        amount: double.parse(_amountController.text),
        categoryCode: _selectedCategory,
        merchant: _merchantController.text,
        details: _detailsController.text,
        date: _selectedDate,
      );

      if (mounted && success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Petty cash expenditure successfully logged.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(logPettyCashFormAdapterProvider);

    return BaseForm(
      formKey: _formKey,
      title: 'Log Petty Cash',
      subtitle: 'Record and categorize localized petty cash expenditure.',
      onSubmit: _submit,
      isLoading: viewModel.isLoading,
      submitText: 'Record Expenditure',
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'common.amount'.tr(),
                  prefixIcon: const Icon(Icons.attach_money),
                  hintText: '0.00',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid amount';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: _selectDate,
                borderRadius: BorderRadius.circular(12),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'common.date'.tr(),
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                  ),
                  child: Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          initialValue: _selectedCategory,
          decoration: InputDecoration(
            labelText: 'common.category'.tr(),
            prefixIcon: const Icon(Icons.category),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
          ),
          items: _categories.map((cat) {
            return DropdownMenuItem(
              value: cat['code'],
              child: Text(cat['name']!),
            );
          }).toList(),
          onChanged: (value) => setState(() => _selectedCategory = value!),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _merchantController,
          decoration: InputDecoration(
            labelText: 'Merchant / Vendor',
            prefixIcon: const Icon(Icons.store),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
          ),
          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _detailsController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Expenditure Details',
            alignLabelWithHint: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
          ),
          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
        ),
      ],
    );
  }
}
