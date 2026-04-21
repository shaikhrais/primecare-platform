// Layer: 02_MODELS_FOUNDATION
class CeoDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardDtoDto({required this.id, required this.raw});

  factory CeoDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
