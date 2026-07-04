class ClinicHistoryLogsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicHistoryLogsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicHistoryLogsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicHistoryLogsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
