class CompetitorAnalysisBoardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CompetitorAnalysisBoardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CompetitorAnalysisBoardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CompetitorAnalysisBoardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
