// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardDtoDto({required this.id, required this.raw});

  factory RegionalBdmDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

