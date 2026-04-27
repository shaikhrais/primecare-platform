import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class AdministrativeFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;
  final bool isSubmitting;

  const AdministrativeFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
    this.isSubmitting = false,
  });

  factory AdministrativeFormsViewModel.initial() {
    return const AdministrativeFormsViewModel(
      availableForms: [
        'Expense Reimbursement',
        'Leave Request Approval',
        'Payroll Run Approval',
      ],
      selectedForm: 'Expense Reimbursement',
    );
  }

  AdministrativeFormsViewModel copyWith({
    List<String>? availableForms,
    String? selectedForm,
    bool? isSubmitting,
  }) {
    return AdministrativeFormsViewModel(
      availableForms: availableForms ?? this.availableForms,
      selectedForm: selectedForm ?? this.selectedForm,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
