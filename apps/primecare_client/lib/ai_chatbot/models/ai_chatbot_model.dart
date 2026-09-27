class AiChatbotModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AiChatbotModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AiChatbotModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AiChatbotModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
