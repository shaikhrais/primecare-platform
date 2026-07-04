class TouchpointAnalyzerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TouchpointAnalyzerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TouchpointAnalyzerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TouchpointAnalyzerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
