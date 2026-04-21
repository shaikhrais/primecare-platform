// Layer: 02_MODELS_FOUNDATION
class LocalMarketingManagerDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  LocalMarketingManagerDashboardMapperDto({required this.id, required this.raw});

  factory LocalMarketingManagerDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return LocalMarketingManagerDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

