// Layer: 02_MODELS_FOUNDATION
class FranchiseOwnerDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseOwnerDashboardAdapterDto({required this.id, required this.raw});

  factory FranchiseOwnerDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseOwnerDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
