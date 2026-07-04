class CoordinatorDispatchMapModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CoordinatorDispatchMapModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CoordinatorDispatchMapModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CoordinatorDispatchMapModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
