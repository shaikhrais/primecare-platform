class CorrectiveActionModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CorrectiveActionModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CorrectiveActionModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CorrectiveActionModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
