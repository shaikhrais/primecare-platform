class FinanceDirectorCashflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FinanceDirectorCashflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FinanceDirectorCashflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FinanceDirectorCashflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
