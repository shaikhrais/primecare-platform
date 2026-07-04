class TerritoryExpansionManagerOpenTerritoriesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TerritoryExpansionManagerOpenTerritoriesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TerritoryExpansionManagerOpenTerritoriesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TerritoryExpansionManagerOpenTerritoriesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
