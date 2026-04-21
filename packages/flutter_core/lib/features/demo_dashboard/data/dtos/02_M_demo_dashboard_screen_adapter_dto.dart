// Layer: 02_MODELS_FOUNDATION
class DemoDashboardScreenAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  DemoDashboardScreenAdapterDto({required this.id, required this.raw});

  factory DemoDashboardScreenAdapterDto.fromJson(Map<String, dynamic> json) {
    return DemoDashboardScreenAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
