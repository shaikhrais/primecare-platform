class TerritoryExpansionManagerForecastModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TerritoryExpansionManagerForecastModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TerritoryExpansionManagerForecastModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TerritoryExpansionManagerForecastModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
