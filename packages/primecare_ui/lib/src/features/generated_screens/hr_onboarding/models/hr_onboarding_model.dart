class HrOnboardingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrOnboardingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrOnboardingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrOnboardingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
