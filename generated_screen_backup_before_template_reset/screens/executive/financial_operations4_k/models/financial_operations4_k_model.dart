class FinancialOperations4KModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FinancialOperations4KModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FinancialOperations4KModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FinancialOperations4KModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
