// Layer: 02_MODELS_FOUNDATION
class MasterDashboardPageDto {
  final String id;
  final Map<String, dynamic> raw;

  MasterDashboardPageDto({required this.id, required this.raw});

  factory MasterDashboardPageDto.fromJson(Map<String, dynamic> json) {
    return MasterDashboardPageDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

