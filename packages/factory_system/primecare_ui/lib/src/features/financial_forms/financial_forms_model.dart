class FinancialFormsViewModel {
  final List<String> availableForms;
  final String selectedForm;

  const FinancialFormsViewModel({
    required this.availableForms,
    required this.selectedForm,
  });

  factory FinancialFormsViewModel.initial() {
    return const FinancialFormsViewModel(
      availableForms: [
        'Expense Reimbursement',
        'Payroll Run',
        'Payroll Discrepancy',
        'Custom Invoice',
        'Revenue Report',
        'Petty Cash',
      ],
      selectedForm: 'Expense Reimbursement',
    );
  }
}
