class ResearchPublicationDraftingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ResearchPublicationDraftingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ResearchPublicationDraftingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ResearchPublicationDraftingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
