class HrDirectorCredentialExpiryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrDirectorCredentialExpiryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrDirectorCredentialExpiryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrDirectorCredentialExpiryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
