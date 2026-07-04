class CustomerSupportTicketsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CustomerSupportTicketsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CustomerSupportTicketsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CustomerSupportTicketsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
