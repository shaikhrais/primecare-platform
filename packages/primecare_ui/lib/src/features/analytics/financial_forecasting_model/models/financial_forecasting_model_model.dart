class FinancialForecastingModelModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FinancialForecastingModelModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FinancialForecastingModelModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FinancialForecastingModelModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
