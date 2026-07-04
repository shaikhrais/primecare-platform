class TerritoryExpansionManagerExpansionPlansModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TerritoryExpansionManagerExpansionPlansModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TerritoryExpansionManagerExpansionPlansModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TerritoryExpansionManagerExpansionPlansModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
