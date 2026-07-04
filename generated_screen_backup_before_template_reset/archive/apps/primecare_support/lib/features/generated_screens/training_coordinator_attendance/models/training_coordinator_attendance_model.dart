class TrainingCoordinatorAttendanceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingCoordinatorAttendanceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingCoordinatorAttendanceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingCoordinatorAttendanceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
