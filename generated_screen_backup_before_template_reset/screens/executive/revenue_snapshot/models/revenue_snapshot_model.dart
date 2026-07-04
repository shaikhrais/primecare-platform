class RevenueSnapshotModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RevenueSnapshotModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RevenueSnapshotModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RevenueSnapshotModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
