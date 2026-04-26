import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';

class ReviewMonthlyExpensesForm extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const ReviewMonthlyExpensesForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<ReviewMonthlyExpensesForm> createState() =>
      _ReviewMonthlyExpensesFormState();
}

class _ReviewMonthlyExpensesFormState extends State<ReviewMonthlyExpensesForm> {
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit({
        'status': 'submitted',
        'timestamp': DateTime.now().toIso8601String(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            LocaleKeys
                .dashboards_common_labels_successfully_tracked_and_submitted
                .tr(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseForm(
      formKey: _formKey,
      title: LocaleKeys.dashboards_common_labels_review_expenses.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_review_franchise_p_l_statements
          .tr(),
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
                  labelText: 'common.name'.tr(),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'common.details'.tr(),
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
