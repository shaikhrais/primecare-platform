class TerritoryExpansionManagerWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TerritoryExpansionManagerWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TerritoryExpansionManagerWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TerritoryExpansionManagerWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
