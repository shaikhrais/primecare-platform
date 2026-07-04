class FinanceDirectorWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FinanceDirectorWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FinanceDirectorWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FinanceDirectorWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
