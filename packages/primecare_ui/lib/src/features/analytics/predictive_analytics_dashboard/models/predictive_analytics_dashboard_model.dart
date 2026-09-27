class PredictiveAnalyticsDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PredictiveAnalyticsDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PredictiveAnalyticsDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PredictiveAnalyticsDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
