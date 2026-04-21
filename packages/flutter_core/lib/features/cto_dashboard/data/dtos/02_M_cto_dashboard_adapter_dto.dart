// Layer: 02_MODELS_FOUNDATION
class CtoDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CtoDashboardAdapterDto({required this.id, required this.raw});

  factory CtoDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return CtoDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
