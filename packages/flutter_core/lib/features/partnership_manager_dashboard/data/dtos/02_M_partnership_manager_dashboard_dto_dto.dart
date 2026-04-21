// Layer: 02_MODELS_FOUNDATION
class PartnershipManagerDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  PartnershipManagerDashboardDtoDto({required this.id, required this.raw});

  factory PartnershipManagerDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return PartnershipManagerDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

