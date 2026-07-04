class CnsWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CnsWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CnsWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CnsWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
