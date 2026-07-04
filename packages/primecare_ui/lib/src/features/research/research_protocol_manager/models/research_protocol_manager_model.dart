class ResearchProtocolManagerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ResearchProtocolManagerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ResearchProtocolManagerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ResearchProtocolManagerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
