class OutreachCampaignModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OutreachCampaignModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OutreachCampaignModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OutreachCampaignModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
