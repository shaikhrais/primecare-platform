class LocalMarketingManagerReportsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LocalMarketingManagerReportsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LocalMarketingManagerReportsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LocalMarketingManagerReportsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
