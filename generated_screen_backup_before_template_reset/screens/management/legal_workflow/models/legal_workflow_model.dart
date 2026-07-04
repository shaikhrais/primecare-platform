class LegalWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LegalWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LegalWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LegalWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
