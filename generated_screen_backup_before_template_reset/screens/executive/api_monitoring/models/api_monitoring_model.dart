class ApiMonitoringModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ApiMonitoringModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ApiMonitoringModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ApiMonitoringModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
