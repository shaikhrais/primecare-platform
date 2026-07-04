class CarePlanModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CarePlanModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CarePlanModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CarePlanModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
