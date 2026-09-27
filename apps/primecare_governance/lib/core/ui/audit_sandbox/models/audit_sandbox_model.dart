class AuditSandboxModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AuditSandboxModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AuditSandboxModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AuditSandboxModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
