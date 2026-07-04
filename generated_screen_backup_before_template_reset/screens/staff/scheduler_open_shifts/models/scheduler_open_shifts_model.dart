class SchedulerOpenShiftsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SchedulerOpenShiftsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SchedulerOpenShiftsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SchedulerOpenShiftsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
