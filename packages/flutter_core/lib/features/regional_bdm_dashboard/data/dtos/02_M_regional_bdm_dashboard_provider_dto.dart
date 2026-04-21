// Layer: 02_MODELS_FOUNDATION
class RegionalBdmDashboardProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalBdmDashboardProviderDto({required this.id, required this.raw});

  factory RegionalBdmDashboardProviderDto.fromJson(Map<String, dynamic> json) {
    return RegionalBdmDashboardProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

