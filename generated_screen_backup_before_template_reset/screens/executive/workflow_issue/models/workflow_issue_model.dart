class WorkflowIssueModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const WorkflowIssueModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  WorkflowIssueModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return WorkflowIssueModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
