class HeadOfMarketingDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HeadOfMarketingDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HeadOfMarketingDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HeadOfMarketingDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
