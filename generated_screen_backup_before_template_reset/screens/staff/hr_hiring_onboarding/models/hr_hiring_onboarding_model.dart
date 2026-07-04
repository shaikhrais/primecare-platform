class HrHiringOnboardingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrHiringOnboardingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrHiringOnboardingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrHiringOnboardingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
