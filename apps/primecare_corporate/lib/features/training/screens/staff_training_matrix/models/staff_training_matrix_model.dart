class StaffTrainingMatrixModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const StaffTrainingMatrixModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  StaffTrainingMatrixModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return StaffTrainingMatrixModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
