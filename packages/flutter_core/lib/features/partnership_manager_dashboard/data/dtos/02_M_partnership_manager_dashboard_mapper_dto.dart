// Layer: 02_MODELS_FOUNDATION
class PartnershipManagerDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  PartnershipManagerDashboardMapperDto({required this.id, required this.raw});

  factory PartnershipManagerDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return PartnershipManagerDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

