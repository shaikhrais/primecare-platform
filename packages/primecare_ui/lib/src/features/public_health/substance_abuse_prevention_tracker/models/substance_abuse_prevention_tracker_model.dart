class SubstanceAbusePreventionTrackerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SubstanceAbusePreventionTrackerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SubstanceAbusePreventionTrackerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SubstanceAbusePreventionTrackerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
