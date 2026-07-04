class PatientTreatmentHistoryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PatientTreatmentHistoryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PatientTreatmentHistoryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PatientTreatmentHistoryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
