class TrainingDirectorStaffTrainingMatrixModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingDirectorStaffTrainingMatrixModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingDirectorStaffTrainingMatrixModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingDirectorStaffTrainingMatrixModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
