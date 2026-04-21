// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardScreenDto({required this.id, required this.raw});

  factory RegionalBdmDashboardScreenDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

