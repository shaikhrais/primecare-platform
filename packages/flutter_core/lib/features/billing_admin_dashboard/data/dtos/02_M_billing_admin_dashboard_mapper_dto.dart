// Layer: 02_MODELS_FOUNDATION
class BillingAdminDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  BillingAdminDashboardMapperDto({required this.id, required this.raw});

  factory BillingAdminDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return BillingAdminDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

