class RnVitalsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnVitalsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnVitalsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnVitalsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
