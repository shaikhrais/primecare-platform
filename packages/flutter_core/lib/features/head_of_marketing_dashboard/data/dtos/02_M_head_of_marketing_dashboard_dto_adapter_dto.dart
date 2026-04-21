// Layer: 02_MODELS_FOUNDATION
class HeadOfMarketingDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  HeadOfMarketingDashboardDtoAdapterDto({required this.id, required this.raw});

  factory HeadOfMarketingDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return HeadOfMarketingDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
