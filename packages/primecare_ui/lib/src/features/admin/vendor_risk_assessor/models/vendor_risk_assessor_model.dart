class VendorRiskAssessorModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const VendorRiskAssessorModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  VendorRiskAssessorModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return VendorRiskAssessorModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
