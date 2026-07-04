class RegionalManagerUsaWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegionalManagerUsaWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegionalManagerUsaWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegionalManagerUsaWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
