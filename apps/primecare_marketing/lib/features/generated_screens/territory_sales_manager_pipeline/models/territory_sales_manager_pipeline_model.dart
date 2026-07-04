class TerritorySalesManagerPipelineModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TerritorySalesManagerPipelineModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TerritorySalesManagerPipelineModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TerritorySalesManagerPipelineModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
