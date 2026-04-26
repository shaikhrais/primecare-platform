// Layer: 02_MODELS_FOUNDATION
class AuditOverrideFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AuditOverrideFormDto({required this.id, required this.raw});

  factory AuditOverrideFormDto.fromJson(Map<String, dynamic> json) {
    return AuditOverrideFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
