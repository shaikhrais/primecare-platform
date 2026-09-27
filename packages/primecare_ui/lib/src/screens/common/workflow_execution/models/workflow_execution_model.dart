class WorkflowExecutionModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const WorkflowExecutionModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  WorkflowExecutionModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return WorkflowExecutionModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
