class CfoAccountsReceivableModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CfoAccountsReceivableModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CfoAccountsReceivableModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CfoAccountsReceivableModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
