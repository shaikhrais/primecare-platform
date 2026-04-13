class ApproveLeaveRequestFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String requestId;
  final String employeeName;
  final String leaveType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;

  ApproveLeaveRequestFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.requestId = '',
    this.employeeName = 'Unknown Employee',
    this.leaveType = 'General Leave',
    this.startDate,
    this.endDate,
    this.status = 'Pending',
  });

  ApproveLeaveRequestFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? requestId,
    String? employeeName,
    String? leaveType,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) {
    return ApproveLeaveRequestFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      requestId: requestId ?? this.requestId,
      employeeName: employeeName ?? this.employeeName,
      leaveType: leaveType ?? this.leaveType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}
