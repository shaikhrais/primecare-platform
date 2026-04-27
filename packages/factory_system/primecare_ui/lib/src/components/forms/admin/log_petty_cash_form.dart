import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/components/forms/base_form.dart';

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
          SnackBar(
            content: Text(
              LocaleKeys
                  .dashboards_common_labels_petty_cash_expenditure_successfully_logged
                  .tr(),
            ),
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
      title: LocaleKeys.dashboards_common_labels_log_petty_cash.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_record_and_categorize_localized_petty_cash_expenditure
          .tr(),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (double.tryParse(value) == null) return 'Invalid amount';
                  return null;
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: _selectDate,
                borderRadius: BorderRadius.circular(12),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'common.date'.tr(),
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  child: Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
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
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
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
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
        ),
      ],
    );
  }
}
