class DigitalSymptomCheckerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DigitalSymptomCheckerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DigitalSymptomCheckerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DigitalSymptomCheckerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
