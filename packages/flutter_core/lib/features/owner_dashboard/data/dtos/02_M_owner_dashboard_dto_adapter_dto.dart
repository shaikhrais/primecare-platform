// Layer: 02_MODELS_FOUNDATION
class OwnerDashboardDtoAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  OwnerDashboardDtoAdapterDto({required this.id, required this.raw});

  factory OwnerDashboardDtoAdapterDto.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardDtoAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
