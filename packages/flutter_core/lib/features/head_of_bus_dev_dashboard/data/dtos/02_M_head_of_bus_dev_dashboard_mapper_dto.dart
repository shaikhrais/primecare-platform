// Layer: 02_MODELS_FOUNDATION
class HeadOfBusDevDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfBusDevDashboardMapperDto({required this.id, required this.raw});

  factory HeadOfBusDevDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return HeadOfBusDevDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

