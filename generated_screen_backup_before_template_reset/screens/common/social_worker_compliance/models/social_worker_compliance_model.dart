class SocialWorkerComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SocialWorkerComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SocialWorkerComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SocialWorkerComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
