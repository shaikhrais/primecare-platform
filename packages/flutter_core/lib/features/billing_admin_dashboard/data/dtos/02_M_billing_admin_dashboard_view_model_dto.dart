// Layer: 02_MODELS_FOUNDATION
class BillingAdminDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  BillingAdminDashboardViewModelDto({required this.id, required this.raw});

  factory BillingAdminDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return BillingAdminDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

