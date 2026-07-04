class CeoFranchiseOverviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CeoFranchiseOverviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CeoFranchiseOverviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CeoFranchiseOverviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
