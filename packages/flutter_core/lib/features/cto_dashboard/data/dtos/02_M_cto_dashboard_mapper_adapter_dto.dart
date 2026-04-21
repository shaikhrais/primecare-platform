// Layer: 02_MODELS_FOUNDATION
class CtoDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CtoDashboardMapperAdapterDto({required this.id, required this.raw});

  factory CtoDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
