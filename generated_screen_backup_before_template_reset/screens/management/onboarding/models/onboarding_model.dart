class OnboardingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OnboardingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OnboardingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OnboardingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
