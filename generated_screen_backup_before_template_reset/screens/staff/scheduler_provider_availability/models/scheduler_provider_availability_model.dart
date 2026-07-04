class SchedulerProviderAvailabilityModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SchedulerProviderAvailabilityModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SchedulerProviderAvailabilityModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SchedulerProviderAvailabilityModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
