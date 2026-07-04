class ResolutionTrackingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ResolutionTrackingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ResolutionTrackingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ResolutionTrackingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
