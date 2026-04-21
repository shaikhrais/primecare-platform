// Layer: 02_MODELS_FOUNDATION
class CooDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardAdapterDto({required this.id, required this.raw});

  factory CooDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
