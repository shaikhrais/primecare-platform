class CustomerSupportTemplatesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CustomerSupportTemplatesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CustomerSupportTemplatesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CustomerSupportTemplatesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
