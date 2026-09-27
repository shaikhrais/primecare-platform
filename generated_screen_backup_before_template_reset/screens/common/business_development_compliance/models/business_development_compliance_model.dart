class BusinessDevelopmentComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BusinessDevelopmentComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BusinessDevelopmentComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BusinessDevelopmentComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
