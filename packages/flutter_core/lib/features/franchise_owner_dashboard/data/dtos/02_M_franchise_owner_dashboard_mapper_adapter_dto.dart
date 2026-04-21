// Layer: 02_MODELS_FOUNDATION
class FranchiseOwnerDashboardMapperAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseOwnerDashboardMapperAdapterDto({required this.id, required this.raw});

  factory FranchiseOwnerDashboardMapperAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseOwnerDashboardMapperAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
