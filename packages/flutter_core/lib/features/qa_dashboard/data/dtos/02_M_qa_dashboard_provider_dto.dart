// Layer: 02_MODELS_FOUNDATION
class QaDashboardProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  QaDashboardProviderDto({required this.id, required this.raw});

  factory QaDashboardProviderDto.fromJson(Map<String, dynamic> json) {
    return QaDashboardProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

