class FranchiseOwnerFinanceSnapshotModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FranchiseOwnerFinanceSnapshotModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FranchiseOwnerFinanceSnapshotModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FranchiseOwnerFinanceSnapshotModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
