class BrandAssetLibraryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BrandAssetLibraryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BrandAssetLibraryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BrandAssetLibraryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
