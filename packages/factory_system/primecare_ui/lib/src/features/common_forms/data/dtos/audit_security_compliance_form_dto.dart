// Layer: 02_MODELS_FOUNDATION
class AuditSecurityComplianceFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AuditSecurityComplianceFormDto({required this.id, required this.raw});

  factory AuditSecurityComplianceFormDto.fromJson(Map<String, dynamic> json) {
    return AuditSecurityComplianceFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
