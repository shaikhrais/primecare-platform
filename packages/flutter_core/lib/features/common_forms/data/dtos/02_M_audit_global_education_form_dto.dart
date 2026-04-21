// Layer: 02_MODELS_FOUNDATION
class AuditGlobalEducationFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AuditGlobalEducationFormDto({required this.id, required this.raw});

  factory AuditGlobalEducationFormDto.fromJson(Map<String, dynamic> json) {
    return AuditGlobalEducationFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

