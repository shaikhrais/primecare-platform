class OnboardingChecklistModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OnboardingChecklistModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OnboardingChecklistModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OnboardingChecklistModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
