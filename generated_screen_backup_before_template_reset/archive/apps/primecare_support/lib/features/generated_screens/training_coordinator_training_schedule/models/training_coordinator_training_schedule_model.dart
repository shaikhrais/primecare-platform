class TrainingCoordinatorTrainingScheduleModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingCoordinatorTrainingScheduleModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingCoordinatorTrainingScheduleModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingCoordinatorTrainingScheduleModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
