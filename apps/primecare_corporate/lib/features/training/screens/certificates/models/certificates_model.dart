class CertificatesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CertificatesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CertificatesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CertificatesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
