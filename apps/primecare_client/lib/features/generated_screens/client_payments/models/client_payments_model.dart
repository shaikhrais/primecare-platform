class ClientPaymentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClientPaymentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClientPaymentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClientPaymentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
