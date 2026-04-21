// Layer: 02_MODELS_FOUNDATION
class FranchiseDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseDashboardMapperAdapterDto({required this.id, required this.raw});

  factory FranchiseDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
