class CredentialTrackingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CredentialTrackingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CredentialTrackingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CredentialTrackingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
