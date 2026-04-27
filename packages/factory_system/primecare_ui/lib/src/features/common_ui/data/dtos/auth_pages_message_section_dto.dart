// Layer: 02_MODELS_FOUNDATION
class AuthPagesMessageSectionDto {
  final String id;
  final Map<String, dynamic> raw;

  AuthPagesMessageSectionDto({required this.id, required this.raw});

  factory AuthPagesMessageSectionDto.fromJson(Map<String, dynamic> json) {
    return AuthPagesMessageSectionDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
