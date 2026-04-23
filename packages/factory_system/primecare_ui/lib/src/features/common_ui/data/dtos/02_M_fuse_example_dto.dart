// Layer: 02_MODELS_FOUNDATION
class FuseExampleDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseExampleDto({required this.id, required this.raw});

  factory FuseExampleDto.fromJson(Map<String, dynamic> json) {
    return FuseExampleDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

