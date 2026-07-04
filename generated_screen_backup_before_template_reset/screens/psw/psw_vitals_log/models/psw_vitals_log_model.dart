class PswVitalsLogModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PswVitalsLogModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PswVitalsLogModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PswVitalsLogModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
