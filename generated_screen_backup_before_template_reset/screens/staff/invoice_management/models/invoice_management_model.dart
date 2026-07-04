class InvoiceManagementModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const InvoiceManagementModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  InvoiceManagementModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return InvoiceManagementModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
