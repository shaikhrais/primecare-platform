class FranchiseOwnerBranchOverviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FranchiseOwnerBranchOverviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FranchiseOwnerBranchOverviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FranchiseOwnerBranchOverviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
