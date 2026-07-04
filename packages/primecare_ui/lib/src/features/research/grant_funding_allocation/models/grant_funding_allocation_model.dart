class GrantFundingAllocationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const GrantFundingAllocationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  GrantFundingAllocationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return GrantFundingAllocationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
