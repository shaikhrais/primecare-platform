class CommunityOutreachDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CommunityOutreachDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CommunityOutreachDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CommunityOutreachDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
