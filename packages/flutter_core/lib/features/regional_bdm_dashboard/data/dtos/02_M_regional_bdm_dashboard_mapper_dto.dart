// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardMapperDto({required this.id, required this.raw});

  factory RegionalBdmDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

