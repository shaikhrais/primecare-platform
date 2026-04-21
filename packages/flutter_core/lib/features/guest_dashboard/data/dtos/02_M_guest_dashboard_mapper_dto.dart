// Layer: 02_MODELS_FOUNDATION
class GuestDashboardMapperDto {
  final String id;
  final Map<String, dynamic> raw;

  GuestDashboardMapperDto({required this.id, required this.raw});

  factory GuestDashboardMapperDto.fromJson(Map<String, dynamic> json) {
    return GuestDashboardMapperDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

