class BoardOfDirectorsSummaryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BoardOfDirectorsSummaryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BoardOfDirectorsSummaryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BoardOfDirectorsSummaryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
