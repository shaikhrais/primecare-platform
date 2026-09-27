class SecurityAuditModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SecurityAuditModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SecurityAuditModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SecurityAuditModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
