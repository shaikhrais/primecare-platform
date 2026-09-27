class BranchPerformanceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BranchPerformanceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BranchPerformanceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BranchPerformanceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
