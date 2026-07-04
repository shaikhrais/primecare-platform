class HeadOfMarketingBrandAssetsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HeadOfMarketingBrandAssetsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HeadOfMarketingBrandAssetsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HeadOfMarketingBrandAssetsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
