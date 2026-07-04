class AdminScreenHealthModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AdminScreenHealthModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AdminScreenHealthModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AdminScreenHealthModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
