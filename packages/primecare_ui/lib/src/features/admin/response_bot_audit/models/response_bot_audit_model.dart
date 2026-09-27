class ResponseBotAuditModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ResponseBotAuditModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ResponseBotAuditModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ResponseBotAuditModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
