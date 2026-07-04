class TrainingDirectorCourseLibraryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingDirectorCourseLibraryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingDirectorCourseLibraryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingDirectorCourseLibraryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
