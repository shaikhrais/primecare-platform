class MarketingManagerCampaignsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MarketingManagerCampaignsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MarketingManagerCampaignsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MarketingManagerCampaignsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
