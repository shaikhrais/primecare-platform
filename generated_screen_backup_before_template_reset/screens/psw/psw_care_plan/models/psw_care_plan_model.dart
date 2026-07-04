class PswCarePlanModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswCarePlanModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswCarePlanModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswCarePlanModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
