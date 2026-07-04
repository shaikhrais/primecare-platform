class LocalMarketingManagerEventsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LocalMarketingManagerEventsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LocalMarketingManagerEventsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LocalMarketingManagerEventsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
