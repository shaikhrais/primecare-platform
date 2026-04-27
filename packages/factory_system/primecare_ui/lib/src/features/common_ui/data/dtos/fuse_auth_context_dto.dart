// Layer: 02_MODELS_FOUNDATION
class FuseAuthContextDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseAuthContextDto({required this.id, required this.raw});

  factory FuseAuthContextDto.fromJson(Map<String, dynamic> json) {
    return FuseAuthContextDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
