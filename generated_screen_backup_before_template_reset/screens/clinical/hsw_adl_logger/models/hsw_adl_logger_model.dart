class HswAdlLoggerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HswAdlLoggerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HswAdlLoggerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HswAdlLoggerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
