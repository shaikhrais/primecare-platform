// Layer: 02_MODELS_FOUNDATION
class AuditPayrollDiscrepancyFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AuditPayrollDiscrepancyFormDto({required this.id, required this.raw});

  factory AuditPayrollDiscrepancyFormDto.fromJson(Map<String, dynamic> json) {
    return AuditPayrollDiscrepancyFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

