class CfoAccountsPayableModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CfoAccountsPayableModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CfoAccountsPayableModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CfoAccountsPayableModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
