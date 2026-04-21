// Layer: 02_MODELS_FOUNDATION
class CooDashboardProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardProviderDto({required this.id, required this.raw});

  factory CooDashboardProviderDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

