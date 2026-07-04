class TrainingCoordinatorDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingCoordinatorDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingCoordinatorDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingCoordinatorDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
