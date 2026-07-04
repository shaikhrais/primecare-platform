class ArchitecturePlanningAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ArchitecturePlanningAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ArchitecturePlanningAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ArchitecturePlanningAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
