// Layer: 02_MODELS_FOUNDATION
class OwnerDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  OwnerDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory OwnerDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
