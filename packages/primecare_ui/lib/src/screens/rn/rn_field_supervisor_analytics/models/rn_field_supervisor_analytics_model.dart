class RnFieldSupervisorAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnFieldSupervisorAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnFieldSupervisorAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnFieldSupervisorAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
