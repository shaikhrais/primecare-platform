class IntakeCoordinatorFollowUpModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const IntakeCoordinatorFollowUpModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  IntakeCoordinatorFollowUpModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return IntakeCoordinatorFollowUpModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
