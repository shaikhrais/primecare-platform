class AuditPayrollDiscrepancyFormDto {
  final Map<String, dynamic> rawData;

  AuditPayrollDiscrepancyFormDto({required this.rawData});

  factory AuditPayrollDiscrepancyFormDto.fromJson(Map<String, dynamic> json) {
    return AuditPayrollDiscrepancyFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
