class HrDirectorHiringPipelineModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrDirectorHiringPipelineModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrDirectorHiringPipelineModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrDirectorHiringPipelineModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
