// Layer: 02_MODELS_FOUNDATION
class ApprovePayrollRunFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String payrollRunId;
  final DateTime? periodStartDate;
  final DateTime? periodEndDate;
  final double totalPayrollAmount;
  final int totalEmployees;
  final String status;

  ApprovePayrollRunFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.payrollRunId = '',
    this.periodStartDate,
    this.periodEndDate,
    this.totalPayrollAmount = 0.0,
    this.totalEmployees = 0,
    this.status = 'Pending',
  });

  ApprovePayrollRunFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? payrollRunId,
    DateTime? periodStartDate,
    DateTime? periodEndDate,
    double? totalPayrollAmount,
    int? totalEmployees,
    String? status,
  }) {
    return ApprovePayrollRunFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      payrollRunId: payrollRunId ?? this.payrollRunId,
      periodStartDate: periodStartDate ?? this.periodStartDate,
      periodEndDate: periodEndDate ?? this.periodEndDate,
      totalPayrollAmount: totalPayrollAmount ?? this.totalPayrollAmount,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      status: status ?? this.status,
    );
  }
}
