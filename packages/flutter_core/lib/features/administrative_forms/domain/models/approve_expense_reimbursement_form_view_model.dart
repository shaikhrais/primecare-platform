class ApproveExpenseReimbursementFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String expenseId;
  final String employeeName;
  final double requestedAmount;
  final String expenseCategory;
  final String description;
  final String status;

  ApproveExpenseReimbursementFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.expenseId = '',
    this.employeeName = 'Unknown Employee',
    this.requestedAmount = 0.0,
    this.expenseCategory = 'Uncategorized',
    this.description = 'No description provided.',
    this.status = 'Pending',
  });

  ApproveExpenseReimbursementFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? expenseId,
    String? employeeName,
    double? requestedAmount,
    String? expenseCategory,
    String? description,
    String? status,
  }) {
    return ApproveExpenseReimbursementFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      expenseId: expenseId ?? this.expenseId,
      employeeName: employeeName ?? this.employeeName,
      requestedAmount: requestedAmount ?? this.requestedAmount,
      expenseCategory: expenseCategory ?? this.expenseCategory,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }
}
