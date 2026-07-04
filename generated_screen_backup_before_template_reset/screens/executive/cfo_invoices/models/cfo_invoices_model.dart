class CfoInvoicesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CfoInvoicesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CfoInvoicesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CfoInvoicesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
