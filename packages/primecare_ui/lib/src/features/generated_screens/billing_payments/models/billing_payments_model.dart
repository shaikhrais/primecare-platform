class BillingPaymentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BillingPaymentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BillingPaymentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BillingPaymentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
