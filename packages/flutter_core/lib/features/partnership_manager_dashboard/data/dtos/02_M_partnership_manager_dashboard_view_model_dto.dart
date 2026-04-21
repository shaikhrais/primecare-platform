// Layer: 02_MODELS_FOUNDATION
class PartnershipManagerDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  PartnershipManagerDashboardViewModelDto({required this.id, required this.raw});

  factory PartnershipManagerDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return PartnershipManagerDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

