class OperationsManagerDailyOperationsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OperationsManagerDailyOperationsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OperationsManagerDailyOperationsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OperationsManagerDailyOperationsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
