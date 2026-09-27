class InterviewSchedulingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const InterviewSchedulingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  InterviewSchedulingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return InterviewSchedulingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
