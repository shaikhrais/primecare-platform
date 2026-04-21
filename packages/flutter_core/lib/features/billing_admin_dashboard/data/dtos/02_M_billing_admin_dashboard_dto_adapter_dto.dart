// Layer: 02_MODELS_FOUNDATION
class BillingAdminDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  BillingAdminDashboardDtoAdapterDto({required this.id, required this.raw});

  factory BillingAdminDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return BillingAdminDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
