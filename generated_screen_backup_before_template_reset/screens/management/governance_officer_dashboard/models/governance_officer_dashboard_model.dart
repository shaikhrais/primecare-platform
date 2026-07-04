class GovernanceOfficerDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const GovernanceOfficerDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  GovernanceOfficerDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return GovernanceOfficerDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
