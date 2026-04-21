// Layer: 02_MODELS_FOUNDATION
class CooDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardDtoAdapterDto({required this.id, required this.raw});

  factory CooDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
