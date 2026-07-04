class ChiropractorClientIntakeModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChiropractorClientIntakeModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChiropractorClientIntakeModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChiropractorClientIntakeModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
