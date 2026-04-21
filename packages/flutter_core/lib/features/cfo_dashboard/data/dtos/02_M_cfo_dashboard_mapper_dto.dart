// Layer: 02_MODELS_FOUNDATION
class CfoDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardMapperDto({required this.id, required this.raw});

  factory CfoDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

