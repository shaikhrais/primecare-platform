class ProviderPerformanceDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ProviderPerformanceDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ProviderPerformanceDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ProviderPerformanceDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
