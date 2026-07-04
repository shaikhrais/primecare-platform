class LocalMarketingManagerCampaignsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LocalMarketingManagerCampaignsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LocalMarketingManagerCampaignsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LocalMarketingManagerCampaignsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
