// Layer: 02_MODELS_FOUNDATION
class AdminDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  AdminDashboardViewModelDto({required this.id, required this.raw});

  factory AdminDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return AdminDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

