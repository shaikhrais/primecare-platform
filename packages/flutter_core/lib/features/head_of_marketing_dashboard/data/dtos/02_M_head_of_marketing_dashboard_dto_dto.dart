// Layer: 02_MODELS_FOUNDATION
class HeadOfMarketingDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfMarketingDashboardDtoDto({required this.id, required this.raw});

  factory HeadOfMarketingDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return HeadOfMarketingDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

