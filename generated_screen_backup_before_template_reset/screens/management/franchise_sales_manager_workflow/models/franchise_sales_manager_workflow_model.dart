class FranchiseSalesManagerWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FranchiseSalesManagerWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FranchiseSalesManagerWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FranchiseSalesManagerWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
