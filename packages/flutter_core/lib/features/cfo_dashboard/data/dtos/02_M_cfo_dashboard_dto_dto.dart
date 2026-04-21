// Layer: 02_MODELS_FOUNDATION
class CfoDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardDtoDto({required this.id, required this.raw});

  factory CfoDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

