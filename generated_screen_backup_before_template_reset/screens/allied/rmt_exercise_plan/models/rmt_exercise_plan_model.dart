class RmtExercisePlanModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RmtExercisePlanModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RmtExercisePlanModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RmtExercisePlanModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
