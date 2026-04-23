// Layer: 02_MODELS_FOUNDATION
class AuditComplianceFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AuditComplianceFormDto({required this.id, required this.raw});

  factory AuditComplianceFormDto.fromJson(Map<String, dynamic> json) {
    return AuditComplianceFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

