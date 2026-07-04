class IntakeCoordinatorAssessmentQueueModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const IntakeCoordinatorAssessmentQueueModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  IntakeCoordinatorAssessmentQueueModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return IntakeCoordinatorAssessmentQueueModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
