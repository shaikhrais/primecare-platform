// Layer: 02_MODELS_FOUNDATION
class FranchiseDashboardAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  FranchiseDashboardAdapterDto({required this.id, required this.raw});

  factory FranchiseDashboardAdapterDto.fromJson(Map<String, dynamic> json) {
    return FranchiseDashboardAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
