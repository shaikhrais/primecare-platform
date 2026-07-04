class StaffUtilizationHeatmapModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const StaffUtilizationHeatmapModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  StaffUtilizationHeatmapModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return StaffUtilizationHeatmapModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
