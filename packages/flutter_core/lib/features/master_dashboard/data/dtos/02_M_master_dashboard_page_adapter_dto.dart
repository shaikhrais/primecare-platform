// Layer: 02_MODELS_FOUNDATION
class MasterDashboardPageAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  MasterDashboardPageAdapterDto({required this.id, required this.raw});

  factory MasterDashboardPageAdapterDto.fromJson(Map<String, dynamic> json) {
    return MasterDashboardPageAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
