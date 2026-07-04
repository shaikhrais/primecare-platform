class ScheduleModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ScheduleModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ScheduleModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ScheduleModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
