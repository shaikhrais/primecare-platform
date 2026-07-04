class HeadOfBusDevWorkflowModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HeadOfBusDevWorkflowModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HeadOfBusDevWorkflowModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HeadOfBusDevWorkflowModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
