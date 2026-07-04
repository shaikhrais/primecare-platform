class HrHiringTrainingStatusModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HrHiringTrainingStatusModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HrHiringTrainingStatusModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HrHiringTrainingStatusModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
