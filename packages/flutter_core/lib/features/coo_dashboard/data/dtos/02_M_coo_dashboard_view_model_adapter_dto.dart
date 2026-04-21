// Layer: 02_MODELS_FOUNDATION
class CooDashboardViewModelAdapterDto {
  final String id;
  final Map<String, dynamic> raw;

  CooDashboardViewModelAdapterDto({required this.id, required this.raw});

  factory CooDashboardViewModelAdapterDto.fromJson(Map<String, dynamic> json) {
    return CooDashboardViewModelAdapterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
