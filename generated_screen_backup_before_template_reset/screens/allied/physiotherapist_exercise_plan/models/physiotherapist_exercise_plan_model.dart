class PhysiotherapistExercisePlanModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PhysiotherapistExercisePlanModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PhysiotherapistExercisePlanModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PhysiotherapistExercisePlanModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
