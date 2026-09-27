class RnChartingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnChartingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnChartingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnChartingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
