class EmailMarketingAutomatorModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const EmailMarketingAutomatorModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  EmailMarketingAutomatorModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return EmailMarketingAutomatorModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
