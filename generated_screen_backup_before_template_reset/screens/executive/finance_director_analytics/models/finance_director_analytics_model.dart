class FinanceDirectorAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const FinanceDirectorAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  FinanceDirectorAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return FinanceDirectorAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
