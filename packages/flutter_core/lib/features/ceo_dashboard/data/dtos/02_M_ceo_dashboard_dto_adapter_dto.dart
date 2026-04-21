// Layer: 02_MODELS_FOUNDATION
class CeoDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CeoDashboardDtoAdapterDto({required this.id, required this.raw});

  factory CeoDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return CeoDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
