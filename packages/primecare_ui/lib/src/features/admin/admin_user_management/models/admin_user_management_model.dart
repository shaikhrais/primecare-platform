class AdminUserManagementModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AdminUserManagementModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AdminUserManagementModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AdminUserManagementModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
