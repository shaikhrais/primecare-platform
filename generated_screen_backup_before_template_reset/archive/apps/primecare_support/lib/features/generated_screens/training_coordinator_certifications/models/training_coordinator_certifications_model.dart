class TrainingCoordinatorCertificationsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingCoordinatorCertificationsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingCoordinatorCertificationsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingCoordinatorCertificationsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
