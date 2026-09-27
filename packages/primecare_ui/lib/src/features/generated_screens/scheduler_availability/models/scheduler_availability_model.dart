class SchedulerAvailabilityModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SchedulerAvailabilityModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SchedulerAvailabilityModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SchedulerAvailabilityModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
