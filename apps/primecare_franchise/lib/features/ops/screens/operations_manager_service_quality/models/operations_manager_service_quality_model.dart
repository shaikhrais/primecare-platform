class OperationsManagerServiceQualityModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OperationsManagerServiceQualityModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OperationsManagerServiceQualityModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OperationsManagerServiceQualityModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
