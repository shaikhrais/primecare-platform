class AdminReconciliationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AdminReconciliationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AdminReconciliationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AdminReconciliationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
