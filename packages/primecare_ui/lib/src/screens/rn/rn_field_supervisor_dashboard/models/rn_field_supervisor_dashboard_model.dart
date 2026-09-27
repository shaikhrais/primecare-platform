class RnFieldSupervisorDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnFieldSupervisorDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnFieldSupervisorDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnFieldSupervisorDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
