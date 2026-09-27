class DailyOperationsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const DailyOperationsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  DailyOperationsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return DailyOperationsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
