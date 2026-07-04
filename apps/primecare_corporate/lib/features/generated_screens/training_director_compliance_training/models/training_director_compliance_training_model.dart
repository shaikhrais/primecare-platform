class TrainingDirectorComplianceTrainingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingDirectorComplianceTrainingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingDirectorComplianceTrainingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingDirectorComplianceTrainingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
