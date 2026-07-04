class TerritorySalesManagerWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TerritorySalesManagerWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TerritorySalesManagerWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TerritorySalesManagerWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
