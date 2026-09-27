class AdminOutstandingBalancesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AdminOutstandingBalancesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AdminOutstandingBalancesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AdminOutstandingBalancesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
