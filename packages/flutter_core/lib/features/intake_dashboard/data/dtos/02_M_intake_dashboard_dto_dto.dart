// Layer: 02_MODELS_FOUNDATION
class IntakeDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  IntakeDashboardDtoDto({required this.id, required this.raw});

  factory IntakeDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return IntakeDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

