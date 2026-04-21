// Layer: 02_MODELS_FOUNDATION
class DailyVitalsCardFormDto {
  final String? id;
  final String? patientId;
  final num? temperature;
  final int? heartRate;
  final int? bloodPressureSystolic;
  final int? bloodPressureDiastolic;
  final int? oxygenSaturation;
  final String? recordedAt;

  DailyVitalsCardFormDto({
    this.id,
    this.patientId,
    this.temperature,
    this.heartRate,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.oxygenSaturation,
    this.recordedAt,
  });

  factory DailyVitalsCardFormDto.fromJson(Map<String, dynamic> json) {
    return DailyVitalsCardFormDto(
      id: json['id'] as String?,
      patientId: json['patientId'] as String?,
      temperature: json['temperature'] as num?,
      heartRate: json['heartRate'] as int?,
      bloodPressureSystolic: json['bloodPressureSystolic'] as int?,
      bloodPressureDiastolic: json['bloodPressureDiastolic'] as int?,
      oxygenSaturation: json['oxygenSaturation'] as int?,
      recordedAt: json['recordedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'temperature': temperature,
      'heartRate': heartRate,
      'bloodPressureSystolic': bloodPressureSystolic,
      'bloodPressureDiastolic': bloodPressureDiastolic,
      'oxygenSaturation': oxygenSaturation,
      'recordedAt': recordedAt,
    };
  }
}
