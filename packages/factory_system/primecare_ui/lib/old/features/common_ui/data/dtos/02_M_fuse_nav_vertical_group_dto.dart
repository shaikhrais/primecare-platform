// Layer: 02_MODELS_FOUNDATION
class FuseNavVerticalGroupDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseNavVerticalGroupDto({required this.id, required this.raw});

  factory FuseNavVerticalGroupDto.fromJson(Map<String, dynamic> json) {
    return FuseNavVerticalGroupDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
