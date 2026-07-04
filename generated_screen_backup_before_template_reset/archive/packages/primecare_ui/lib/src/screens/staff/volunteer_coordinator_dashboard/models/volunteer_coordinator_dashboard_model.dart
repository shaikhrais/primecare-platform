class VolunteerCoordinatorDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const VolunteerCoordinatorDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  VolunteerCoordinatorDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return VolunteerCoordinatorDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
