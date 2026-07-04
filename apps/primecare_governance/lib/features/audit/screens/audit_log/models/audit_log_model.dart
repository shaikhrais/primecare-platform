class AuditLogModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AuditLogModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AuditLogModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AuditLogModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
