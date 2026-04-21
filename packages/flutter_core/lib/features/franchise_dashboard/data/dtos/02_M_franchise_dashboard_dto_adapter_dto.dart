// Layer: 02_MODELS_FOUNDATION
class FranchiseDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseDashboardDtoAdapterDto({required this.id, required this.raw});

  factory FranchiseDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
