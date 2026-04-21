// Layer: 02_MODELS_FOUNDATION
class CfoDashboardScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardScreenDto({required this.id, required this.raw});

  factory CfoDashboardScreenDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

