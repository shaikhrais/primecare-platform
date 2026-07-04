class PatientAppointmentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PatientAppointmentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PatientAppointmentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PatientAppointmentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
