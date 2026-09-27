class IntegrationHealthMonitorModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const IntegrationHealthMonitorModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  IntegrationHealthMonitorModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return IntegrationHealthMonitorModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
