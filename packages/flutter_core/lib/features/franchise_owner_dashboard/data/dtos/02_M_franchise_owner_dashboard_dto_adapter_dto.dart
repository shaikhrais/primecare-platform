// Layer: 02_MODELS_FOUNDATION
class FranchiseOwnerDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseOwnerDashboardDtoAdapterDto({required this.id, required this.raw});

  factory FranchiseOwnerDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseOwnerDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
