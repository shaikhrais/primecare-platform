// Layer: 02_MODELS_FOUNDATION
class HeadOfMarketingDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfMarketingDashboardAdapterDto({required this.id, required this.raw});

  factory HeadOfMarketingDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return HeadOfMarketingDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
