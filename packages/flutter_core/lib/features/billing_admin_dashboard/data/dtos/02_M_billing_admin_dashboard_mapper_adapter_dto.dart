// Layer: 02_MODELS_FOUNDATION
class BillingAdminDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  BillingAdminDashboardMapperAdapterDto({required this.id, required this.raw});

  factory BillingAdminDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return BillingAdminDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
