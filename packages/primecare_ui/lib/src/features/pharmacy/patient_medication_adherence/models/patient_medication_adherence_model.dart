class PatientMedicationAdherenceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PatientMedicationAdherenceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PatientMedicationAdherenceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PatientMedicationAdherenceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
