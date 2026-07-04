class ArchitecturePlanningComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ArchitecturePlanningComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ArchitecturePlanningComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ArchitecturePlanningComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
