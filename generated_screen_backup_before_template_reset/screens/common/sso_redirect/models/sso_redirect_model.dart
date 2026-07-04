class SsoRedirectModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SsoRedirectModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SsoRedirectModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SsoRedirectModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
