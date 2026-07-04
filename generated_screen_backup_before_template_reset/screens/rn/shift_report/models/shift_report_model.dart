class ShiftReportModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ShiftReportModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ShiftReportModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ShiftReportModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
