class ChiropractorDashboardModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChiropractorDashboardModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChiropractorDashboardModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChiropractorDashboardModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
