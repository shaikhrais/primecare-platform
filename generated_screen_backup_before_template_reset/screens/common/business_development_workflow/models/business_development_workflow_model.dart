class BusinessDevelopmentWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BusinessDevelopmentWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BusinessDevelopmentWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BusinessDevelopmentWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
