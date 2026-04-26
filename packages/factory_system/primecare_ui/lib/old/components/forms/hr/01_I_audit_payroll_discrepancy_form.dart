import 'package:primecare_ui/primecare_ui.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/components/forms/01_I_base_form.dart';

class AuditPayrollDiscrepancyForm extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSubmit;
  final bool isLoading;

  const AuditPayrollDiscrepancyForm({
    super.key,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<AuditPayrollDiscrepancyForm> createState() =>
      _AuditPayrollDiscrepancyFormState();
}

class _AuditPayrollDiscrepancyFormState
    extends State<AuditPayrollDiscrepancyForm> {
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
      title: LocaleKeys.dashboards_common_labels_audit_payroll_discrepancy.tr(),
      subtitle: LocaleKeys
          .dashboards_common_labels_review_flagged_time_sheet_anomalies
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
