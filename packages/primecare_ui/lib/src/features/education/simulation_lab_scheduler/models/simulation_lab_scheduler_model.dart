class SimulationLabSchedulerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SimulationLabSchedulerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SimulationLabSchedulerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SimulationLabSchedulerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
