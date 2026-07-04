class SecuritySentinelModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SecuritySentinelModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SecuritySentinelModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SecuritySentinelModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
