class RegionalBdmTerritoryGrowthModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegionalBdmTerritoryGrowthModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegionalBdmTerritoryGrowthModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegionalBdmTerritoryGrowthModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
