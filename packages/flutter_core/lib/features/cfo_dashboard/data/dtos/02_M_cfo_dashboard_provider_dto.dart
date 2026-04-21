// Layer: 02_MODELS_FOUNDATION
class CfoDashboardProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  CfoDashboardProviderDto({required this.id, required this.raw});

  factory CfoDashboardProviderDto.fromJson(Map<String, dynamic> json) {
    return CfoDashboardProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

