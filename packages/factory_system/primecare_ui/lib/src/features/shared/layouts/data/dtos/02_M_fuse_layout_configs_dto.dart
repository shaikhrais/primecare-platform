// Layer: 02_MODELS_FOUNDATION
class FuseLayoutConfigsDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseLayoutConfigsDto({required this.id, required this.raw});

  factory FuseLayoutConfigsDto.fromJson(Map<String, dynamic> json) {
    return FuseLayoutConfigsDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

