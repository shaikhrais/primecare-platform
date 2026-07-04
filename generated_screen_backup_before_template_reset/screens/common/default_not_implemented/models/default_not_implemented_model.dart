class DefaultNotImplementedModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DefaultNotImplementedModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DefaultNotImplementedModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DefaultNotImplementedModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
