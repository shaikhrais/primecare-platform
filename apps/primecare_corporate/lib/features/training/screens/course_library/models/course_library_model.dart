class CourseLibraryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CourseLibraryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CourseLibraryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CourseLibraryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
