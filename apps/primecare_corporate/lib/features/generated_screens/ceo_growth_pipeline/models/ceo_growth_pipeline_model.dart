class CeoGrowthPipelineModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CeoGrowthPipelineModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CeoGrowthPipelineModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CeoGrowthPipelineModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
