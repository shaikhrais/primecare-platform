class ResidencyProgramTrackerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ResidencyProgramTrackerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ResidencyProgramTrackerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ResidencyProgramTrackerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
