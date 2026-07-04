class RnFieldSupervisorWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnFieldSupervisorWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnFieldSupervisorWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnFieldSupervisorWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
