// Layer: 02_MODELS_FOUNDATION
class RegionalManagerOntarioDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  RegionalManagerOntarioDashboardDtoDto({required this.id, required this.raw});

  factory RegionalManagerOntarioDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return RegionalManagerOntarioDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

