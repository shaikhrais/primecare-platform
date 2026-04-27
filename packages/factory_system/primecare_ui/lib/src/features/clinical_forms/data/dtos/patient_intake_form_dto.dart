// Layer: 02_MODELS_FOUNDATION
class PatientIntakeFormDto {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? dateOfBirth;
  final String? healthCardNumber;
  final String? primaryDiagnosis;
  final List<String>? allergies;
  final String? status;

  PatientIntakeFormDto({
    this.id,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.healthCardNumber,
    this.primaryDiagnosis,
    this.allergies,
    this.status,
  });

  factory PatientIntakeFormDto.fromJson(Map<String, dynamic> json) {
    return PatientIntakeFormDto(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      healthCardNumber: json['healthCardNumber'] as String?,
      primaryDiagnosis: json['primaryDiagnosis'] as String?,
      allergies: (json['allergies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'healthCardNumber': healthCardNumber,
      'primaryDiagnosis': primaryDiagnosis,
      'allergies': allergies,
      'status': status,
    };
  }
}
