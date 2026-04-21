// Layer: 02_MODELS_FOUNDATION
class LocalMarketingManagerDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  LocalMarketingManagerDashboardDtoDto({required this.id, required this.raw});

  factory LocalMarketingManagerDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return LocalMarketingManagerDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

