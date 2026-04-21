// Layer: 02_MODELS_FOUNDATION
class CtoDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CtoDashboardDtoAdapterDto({required this.id, required this.raw});

  factory CtoDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
