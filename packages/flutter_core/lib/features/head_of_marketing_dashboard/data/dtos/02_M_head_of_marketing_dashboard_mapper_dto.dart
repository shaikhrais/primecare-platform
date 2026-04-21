// Layer: 02_MODELS_FOUNDATION
class HeadOfMarketingDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfMarketingDashboardMapperDto({required this.id, required this.raw});

  factory HeadOfMarketingDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return HeadOfMarketingDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

