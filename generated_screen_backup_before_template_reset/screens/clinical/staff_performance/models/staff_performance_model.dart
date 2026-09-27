class StaffPerformanceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const StaffPerformanceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  StaffPerformanceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return StaffPerformanceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
