class ApplicantTrackingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ApplicantTrackingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ApplicantTrackingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ApplicantTrackingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
