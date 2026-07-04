class CooWorkflowPerformanceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CooWorkflowPerformanceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CooWorkflowPerformanceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CooWorkflowPerformanceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
