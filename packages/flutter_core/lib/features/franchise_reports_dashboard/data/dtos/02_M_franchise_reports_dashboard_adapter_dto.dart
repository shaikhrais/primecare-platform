// Layer: 02_MODELS_FOUNDATION
class FranchiseReportsDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseReportsDashboardAdapterDto({required this.id, required this.raw});

  factory FranchiseReportsDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseReportsDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
