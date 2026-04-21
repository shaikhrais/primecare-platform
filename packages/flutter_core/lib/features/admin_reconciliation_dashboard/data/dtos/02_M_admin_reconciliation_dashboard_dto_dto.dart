// Layer: 02_MODELS_FOUNDATION
class AdminReconciliationDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminReconciliationDashboardDtoDto({required this.id, required this.raw});

  factory AdminReconciliationDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return AdminReconciliationDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

