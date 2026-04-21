// Layer: 02_MODELS_FOUNDATION
class GuestDashboardViewModelDto {
  final String id;
  final Map<String, dynamic> raw;

  GuestDashboardViewModelDto({required this.id, required this.raw});

  factory GuestDashboardViewModelDto.fromJson(Map<String, dynamic> json) {
    return GuestDashboardViewModelDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

