class CoordinatorHubModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CoordinatorHubModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CoordinatorHubModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CoordinatorHubModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
