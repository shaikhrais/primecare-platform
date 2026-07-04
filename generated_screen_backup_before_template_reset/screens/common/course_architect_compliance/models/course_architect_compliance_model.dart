class CourseArchitectComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CourseArchitectComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CourseArchitectComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CourseArchitectComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
