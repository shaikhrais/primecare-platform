class CertificationRenewalAlertsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CertificationRenewalAlertsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CertificationRenewalAlertsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CertificationRenewalAlertsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
