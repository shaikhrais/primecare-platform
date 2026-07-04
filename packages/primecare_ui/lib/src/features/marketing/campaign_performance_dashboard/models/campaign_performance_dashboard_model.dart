class CampaignPerformanceDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CampaignPerformanceDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CampaignPerformanceDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CampaignPerformanceDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
