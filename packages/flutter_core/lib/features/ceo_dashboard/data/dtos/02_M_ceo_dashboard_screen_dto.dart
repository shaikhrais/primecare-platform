// Layer: 02_MODELS_FOUNDATION
class CeoDashboardScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardScreenDto({required this.id, required this.raw});

  factory CeoDashboardScreenDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

