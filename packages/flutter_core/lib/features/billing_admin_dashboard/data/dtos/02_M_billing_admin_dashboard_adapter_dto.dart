// Layer: 02_MODELS_FOUNDATION
class BillingAdminDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  BillingAdminDashboardAdapterDto({required this.id, required this.raw});

  factory BillingAdminDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return BillingAdminDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
