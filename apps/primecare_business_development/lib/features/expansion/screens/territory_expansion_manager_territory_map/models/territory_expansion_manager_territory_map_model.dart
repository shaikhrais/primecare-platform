class TerritoryExpansionManagerTerritoryMapModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TerritoryExpansionManagerTerritoryMapModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TerritoryExpansionManagerTerritoryMapModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TerritoryExpansionManagerTerritoryMapModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
