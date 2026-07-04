class BusinessDevelopmentDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BusinessDevelopmentDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BusinessDevelopmentDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BusinessDevelopmentDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
