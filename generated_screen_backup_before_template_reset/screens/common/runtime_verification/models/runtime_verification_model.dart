class RuntimeVerificationModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RuntimeVerificationModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RuntimeVerificationModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RuntimeVerificationModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
