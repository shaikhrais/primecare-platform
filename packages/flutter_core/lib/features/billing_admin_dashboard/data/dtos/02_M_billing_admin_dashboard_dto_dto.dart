// Layer: 02_MODELS_FOUNDATION
class BillingAdminDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  BillingAdminDashboardDtoDto({required this.id, required this.raw});

  factory BillingAdminDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return BillingAdminDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

