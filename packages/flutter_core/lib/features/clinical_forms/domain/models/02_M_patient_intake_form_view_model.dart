// Layer: 02_MODELS_FOUNDATION
class PatientIntakeFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String patientId;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String healthCardNumber;
  final String primaryDiagnosis;
  final List<String> allergies;
  final String status;

  PatientIntakeFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.patientId = '',
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth,
    this.healthCardNumber = '',
    this.primaryDiagnosis = '',
    this.allergies = const [],
    this.status = 'Draft',
  });

  PatientIntakeFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? patientId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? healthCardNumber,
    String? primaryDiagnosis,
    List<String>? allergies,
    String? status,
  }) {
    return PatientIntakeFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      patientId: patientId ?? this.patientId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      healthCardNumber: healthCardNumber ?? this.healthCardNumber,
      primaryDiagnosis: primaryDiagnosis ?? this.primaryDiagnosis,
      allergies: allergies ?? this.allergies,
      status: status ?? this.status,
    );
  }
}
