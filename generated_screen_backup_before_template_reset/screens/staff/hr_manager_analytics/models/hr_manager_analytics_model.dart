class HrManagerAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrManagerAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrManagerAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrManagerAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
