// Layer: 02_MODELS_FOUNDATION
class GuestDashboardDtoDto {
  final String id;
  final Map<String, dynamic> raw;

  GuestDashboardDtoDto({required this.id, required this.raw});

  factory GuestDashboardDtoDto.fromJson(Map<String, dynamic> json) {
    return GuestDashboardDtoDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

