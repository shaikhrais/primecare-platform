// Layer: 02_MODELS_FOUNDATION
class FuseAuthorizationDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseAuthorizationDto({required this.id, required this.raw});

  factory FuseAuthorizationDto.fromJson(Map<String, dynamic> json) {
    return FuseAuthorizationDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
