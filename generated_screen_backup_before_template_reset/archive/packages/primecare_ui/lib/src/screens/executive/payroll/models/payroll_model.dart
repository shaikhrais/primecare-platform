class PayrollModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PayrollModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PayrollModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PayrollModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
