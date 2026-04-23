// Layer: 02_MODELS_FOUNDATION
class AuditSystemLogsFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AuditSystemLogsFormDto({required this.id, required this.raw});

  factory AuditSystemLogsFormDto.fromJson(Map<String, dynamic> json) {
    return AuditSystemLogsFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

