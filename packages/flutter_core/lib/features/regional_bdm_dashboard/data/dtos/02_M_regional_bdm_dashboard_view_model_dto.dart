// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardViewModelDto({required this.id, required this.raw});

  factory RegionalBdmDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

