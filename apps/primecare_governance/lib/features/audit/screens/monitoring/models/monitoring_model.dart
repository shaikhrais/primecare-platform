class MonitoringModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MonitoringModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MonitoringModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MonitoringModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
