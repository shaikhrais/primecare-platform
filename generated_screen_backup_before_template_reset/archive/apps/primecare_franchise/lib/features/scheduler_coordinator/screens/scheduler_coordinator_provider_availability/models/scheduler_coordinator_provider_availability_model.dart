class SchedulerCoordinatorProviderAvailabilityModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SchedulerCoordinatorProviderAvailabilityModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SchedulerCoordinatorProviderAvailabilityModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SchedulerCoordinatorProviderAvailabilityModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
