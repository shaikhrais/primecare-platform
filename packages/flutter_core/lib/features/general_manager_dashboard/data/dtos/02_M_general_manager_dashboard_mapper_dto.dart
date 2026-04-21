// Layer: 02_MODELS_FOUNDATION
class GeneralManagerDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  GeneralManagerDashboardMapperDto({required this.id, required this.raw});

  factory GeneralManagerDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return GeneralManagerDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

