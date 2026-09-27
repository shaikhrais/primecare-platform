class RnMessagingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnMessagingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnMessagingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnMessagingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
