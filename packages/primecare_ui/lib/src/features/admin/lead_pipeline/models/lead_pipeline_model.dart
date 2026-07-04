class LeadPipelineModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LeadPipelineModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LeadPipelineModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LeadPipelineModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
