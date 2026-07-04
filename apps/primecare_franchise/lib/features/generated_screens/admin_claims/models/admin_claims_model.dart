class AdminClaimsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AdminClaimsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AdminClaimsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AdminClaimsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
