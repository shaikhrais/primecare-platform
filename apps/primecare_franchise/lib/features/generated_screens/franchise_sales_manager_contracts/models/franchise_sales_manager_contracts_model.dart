class FranchiseSalesManagerContractsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FranchiseSalesManagerContractsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FranchiseSalesManagerContractsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FranchiseSalesManagerContractsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
