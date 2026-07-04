class ComplianceManagerAuditsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ComplianceManagerAuditsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ComplianceManagerAuditsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ComplianceManagerAuditsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
