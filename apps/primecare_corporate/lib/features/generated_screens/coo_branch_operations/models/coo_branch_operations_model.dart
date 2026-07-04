class CooBranchOperationsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CooBranchOperationsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CooBranchOperationsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CooBranchOperationsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
