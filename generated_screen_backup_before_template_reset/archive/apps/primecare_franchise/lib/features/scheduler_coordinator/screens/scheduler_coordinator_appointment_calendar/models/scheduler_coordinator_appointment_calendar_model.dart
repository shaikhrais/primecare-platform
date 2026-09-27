class SchedulerCoordinatorAppointmentCalendarModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SchedulerCoordinatorAppointmentCalendarModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SchedulerCoordinatorAppointmentCalendarModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SchedulerCoordinatorAppointmentCalendarModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
