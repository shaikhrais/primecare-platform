class OperationalEfficiencyMetricsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OperationalEfficiencyMetricsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OperationalEfficiencyMetricsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OperationalEfficiencyMetricsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
