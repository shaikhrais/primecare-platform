class ApproveMedicationRefillFormDto {
  final String? id;
  final String? patientId;
  final String? medicationName;
  final String? dosage;
  final int? quantity;
  final String? requestingPhysician;
  final String? status;

  ApproveMedicationRefillFormDto({
    this.id,
    this.patientId,
    this.medicationName,
    this.dosage,
    this.quantity,
    this.requestingPhysician,
    this.status,
  });

  factory ApproveMedicationRefillFormDto.fromJson(Map<String, dynamic> json) {
    return ApproveMedicationRefillFormDto(
      id: json['id'] as String?,
      patientId: json['patientId'] as String?,
      medicationName: json['medicationName'] as String?,
      dosage: json['dosage'] as String?,
      quantity: json['quantity'] as int?,
      requestingPhysician: json['requestingPhysician'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'medicationName': medicationName,
      'dosage': dosage,
      'quantity': quantity,
      'requestingPhysician': requestingPhysician,
      'status': status,
    };
  }
}
