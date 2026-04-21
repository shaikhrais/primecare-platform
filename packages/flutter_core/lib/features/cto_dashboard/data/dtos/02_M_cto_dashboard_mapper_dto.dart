// Layer: 02_MODELS_FOUNDATION
class CtoDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  CtoDashboardMapperDto({required this.id, required this.raw});

  factory CtoDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

