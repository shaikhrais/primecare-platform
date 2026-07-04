class ArchitecturePlanningWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ArchitecturePlanningWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ArchitecturePlanningWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ArchitecturePlanningWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
