// Layer: 02_MODELS_FOUNDATION
class AdminReconciliationDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminReconciliationDashboardAdapterDto({required this.id, required this.raw});

  factory AdminReconciliationDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return AdminReconciliationDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
