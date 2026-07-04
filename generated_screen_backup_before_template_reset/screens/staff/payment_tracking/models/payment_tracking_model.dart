class PaymentTrackingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PaymentTrackingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PaymentTrackingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PaymentTrackingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
