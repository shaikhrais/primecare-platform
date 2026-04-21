// Layer: 02_MODELS_FOUNDATION
class AdminReconciliationDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminReconciliationDashboardMapperDto({required this.id, required this.raw});

  factory AdminReconciliationDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return AdminReconciliationDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

