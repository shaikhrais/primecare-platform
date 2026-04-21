// Layer: 02_MODELS_FOUNDATION
class CeoDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardMapperDto({required this.id, required this.raw});

  factory CeoDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

