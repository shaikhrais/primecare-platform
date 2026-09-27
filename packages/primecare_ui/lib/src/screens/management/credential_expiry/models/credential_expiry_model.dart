class CredentialExpiryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CredentialExpiryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CredentialExpiryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CredentialExpiryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
