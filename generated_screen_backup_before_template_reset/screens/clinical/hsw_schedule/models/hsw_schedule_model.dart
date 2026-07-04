class HswScheduleModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HswScheduleModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HswScheduleModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HswScheduleModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
