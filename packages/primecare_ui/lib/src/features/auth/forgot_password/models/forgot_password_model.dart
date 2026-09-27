class ForgotPasswordModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ForgotPasswordModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ForgotPasswordModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ForgotPasswordModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
