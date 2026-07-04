class LocalMarketingManagerLeadsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LocalMarketingManagerLeadsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LocalMarketingManagerLeadsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LocalMarketingManagerLeadsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
