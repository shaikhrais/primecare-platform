class CommunityHealthNeedsAssessmentModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CommunityHealthNeedsAssessmentModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CommunityHealthNeedsAssessmentModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CommunityHealthNeedsAssessmentModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
