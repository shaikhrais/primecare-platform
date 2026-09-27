class ClinicalGuidelineLibraryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalGuidelineLibraryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalGuidelineLibraryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalGuidelineLibraryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
