class EmployeeWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const EmployeeWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  EmployeeWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return EmployeeWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
