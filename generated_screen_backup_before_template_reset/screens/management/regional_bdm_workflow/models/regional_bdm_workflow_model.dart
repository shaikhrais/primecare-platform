class RegionalBdmWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegionalBdmWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegionalBdmWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegionalBdmWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
