class PatientTrialOutcomeserModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PatientTrialOutcomeserModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PatientTrialOutcomeserModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PatientTrialOutcomeserModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
