class GovernanceOfficerComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const GovernanceOfficerComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  GovernanceOfficerComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return GovernanceOfficerComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
