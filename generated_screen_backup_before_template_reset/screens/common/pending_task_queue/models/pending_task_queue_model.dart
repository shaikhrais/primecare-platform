class PendingTaskQueueModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PendingTaskQueueModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PendingTaskQueueModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PendingTaskQueueModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
