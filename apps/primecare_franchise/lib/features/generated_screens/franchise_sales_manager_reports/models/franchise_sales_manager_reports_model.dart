class FranchiseSalesManagerReportsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FranchiseSalesManagerReportsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FranchiseSalesManagerReportsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FranchiseSalesManagerReportsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
