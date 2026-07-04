class SchedulerCoordinatorBookingRequestsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SchedulerCoordinatorBookingRequestsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SchedulerCoordinatorBookingRequestsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SchedulerCoordinatorBookingRequestsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
