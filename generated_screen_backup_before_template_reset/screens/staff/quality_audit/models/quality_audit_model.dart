class QualityAuditModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const QualityAuditModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  QualityAuditModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return QualityAuditModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
