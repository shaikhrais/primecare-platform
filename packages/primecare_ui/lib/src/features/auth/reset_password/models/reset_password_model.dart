class ResetPasswordModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ResetPasswordModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ResetPasswordModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ResetPasswordModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
