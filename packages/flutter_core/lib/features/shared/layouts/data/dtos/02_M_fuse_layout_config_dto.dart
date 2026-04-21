// Layer: 02_MODELS_FOUNDATION
class FuseLayoutConfigDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseLayoutConfigDto({required this.id, required this.raw});

  factory FuseLayoutConfigDto.fromJson(Map<String, dynamic> json) {
    return FuseLayoutConfigDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

