// Layer: 02_MODELS_FOUNDATION
class GeneralManagerDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  GeneralManagerDashboardDtoDto({required this.id, required this.raw});

  factory GeneralManagerDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return GeneralManagerDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

