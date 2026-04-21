// Layer: 02_MODELS_FOUNDATION
class CeoDashboardProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardProviderDto({required this.id, required this.raw});

  factory CeoDashboardProviderDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

