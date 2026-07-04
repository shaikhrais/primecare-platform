class PswMessagesModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswMessagesModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswMessagesModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswMessagesModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
