class ChiropractorCommandCenterModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChiropractorCommandCenterModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChiropractorCommandCenterModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChiropractorCommandCenterModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
