class ChronicCareManagementTrackerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChronicCareManagementTrackerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChronicCareManagementTrackerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChronicCareManagementTrackerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
