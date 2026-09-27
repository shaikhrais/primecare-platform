class ScreenAuditModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ScreenAuditModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ScreenAuditModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ScreenAuditModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
