class IntakeCoordinatorBookingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const IntakeCoordinatorBookingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  IntakeCoordinatorBookingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return IntakeCoordinatorBookingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
