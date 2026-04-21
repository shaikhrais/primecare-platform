// Layer: 02_MODELS_FOUNDATION
class JwtAuthProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  JwtAuthProviderDto({required this.id, required this.raw});

  factory JwtAuthProviderDto.fromJson(Map<String, dynamic> json) {
    return JwtAuthProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

