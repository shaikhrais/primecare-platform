// Layer: 02_MODELS_FOUNDATION
class HeadOfBusDevDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfBusDevDashboardDtoDto({required this.id, required this.raw});

  factory HeadOfBusDevDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return HeadOfBusDevDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

