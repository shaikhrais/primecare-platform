class VerificationCenterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const VerificationCenterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  VerificationCenterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return VerificationCenterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
