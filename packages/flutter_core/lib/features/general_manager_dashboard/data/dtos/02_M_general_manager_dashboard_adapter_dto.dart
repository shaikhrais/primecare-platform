// Layer: 02_MODELS_FOUNDATION
class GeneralManagerDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  GeneralManagerDashboardAdapterDto({required this.id, required this.raw});

  factory GeneralManagerDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return GeneralManagerDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
