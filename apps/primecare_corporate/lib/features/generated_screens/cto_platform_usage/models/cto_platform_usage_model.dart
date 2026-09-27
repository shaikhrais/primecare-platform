class CtoPlatformUsageModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CtoPlatformUsageModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CtoPlatformUsageModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CtoPlatformUsageModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
