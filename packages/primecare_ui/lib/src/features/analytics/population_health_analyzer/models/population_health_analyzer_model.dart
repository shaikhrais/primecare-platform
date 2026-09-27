class PopulationHealthAnalyzerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PopulationHealthAnalyzerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PopulationHealthAnalyzerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PopulationHealthAnalyzerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
