class TrainingDirectorCourseArchitectModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingDirectorCourseArchitectModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingDirectorCourseArchitectModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingDirectorCourseArchitectModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
