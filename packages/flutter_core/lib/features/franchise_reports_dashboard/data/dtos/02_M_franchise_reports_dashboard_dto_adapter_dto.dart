// Layer: 02_MODELS_FOUNDATION
class FranchiseReportsDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseReportsDashboardDtoAdapterDto({required this.id, required this.raw});

  factory FranchiseReportsDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseReportsDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
