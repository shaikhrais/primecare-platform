class IntakeCoordinatorEligibilityModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const IntakeCoordinatorEligibilityModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  IntakeCoordinatorEligibilityModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return IntakeCoordinatorEligibilityModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
