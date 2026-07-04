class PswMessagingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswMessagingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswMessagingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswMessagingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
