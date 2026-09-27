class SchedulerCoordinatorConflictsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SchedulerCoordinatorConflictsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SchedulerCoordinatorConflictsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SchedulerCoordinatorConflictsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
