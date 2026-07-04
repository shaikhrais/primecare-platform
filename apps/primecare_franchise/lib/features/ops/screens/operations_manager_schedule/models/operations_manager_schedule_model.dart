class OperationsManagerScheduleModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const OperationsManagerScheduleModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  OperationsManagerScheduleModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return OperationsManagerScheduleModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
