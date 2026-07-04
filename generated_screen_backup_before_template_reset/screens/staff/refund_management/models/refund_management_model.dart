class RefundManagementModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RefundManagementModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RefundManagementModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RefundManagementModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
