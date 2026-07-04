class BillingAdminInvoicesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BillingAdminInvoicesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BillingAdminInvoicesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BillingAdminInvoicesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
