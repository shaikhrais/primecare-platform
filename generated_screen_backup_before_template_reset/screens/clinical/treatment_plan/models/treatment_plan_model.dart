class TreatmentPlanModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TreatmentPlanModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TreatmentPlanModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TreatmentPlanModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
