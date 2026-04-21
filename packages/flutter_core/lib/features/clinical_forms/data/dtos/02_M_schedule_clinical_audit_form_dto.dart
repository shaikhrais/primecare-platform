// Layer: 02_MODELS_FOUNDATION
class ScheduleClinicalAuditFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ScheduleClinicalAuditFormDto({required this.id, required this.raw});

  factory ScheduleClinicalAuditFormDto.fromJson(Map<String, dynamic> json) {
    return ScheduleClinicalAuditFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

