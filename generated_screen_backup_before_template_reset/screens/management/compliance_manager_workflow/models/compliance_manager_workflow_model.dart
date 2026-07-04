class ComplianceManagerWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ComplianceManagerWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ComplianceManagerWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ComplianceManagerWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
