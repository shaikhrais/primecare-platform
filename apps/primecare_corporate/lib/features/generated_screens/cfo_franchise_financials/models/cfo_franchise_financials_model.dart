class CfoFranchiseFinancialsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CfoFranchiseFinancialsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CfoFranchiseFinancialsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CfoFranchiseFinancialsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
