class ApiKeyManagerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ApiKeyManagerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ApiKeyManagerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ApiKeyManagerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
