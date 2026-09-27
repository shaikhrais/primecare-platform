class CooBranchComparisonModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CooBranchComparisonModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CooBranchComparisonModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CooBranchComparisonModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
