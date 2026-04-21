// Layer: 02_MODELS_FOUNDATION
class IntakeDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  IntakeDashboardDtoAdapterDto({required this.id, required this.raw});

  factory IntakeDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return IntakeDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
