// Layer: 02_MODELS_FOUNDATION
class CtoDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  CtoDashboardDtoDto({required this.id, required this.raw});

  factory CtoDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

