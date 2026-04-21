// Layer: 02_MODELS_FOUNDATION
class IntakeDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  IntakeDashboardAdapterDto({required this.id, required this.raw});

  factory IntakeDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return IntakeDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
