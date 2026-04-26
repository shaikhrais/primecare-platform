// Layer: 02_MODELS_FOUNDATION
class SignUpPageViewDto {
  final String id;
  final Map<String, dynamic> raw;

  SignUpPageViewDto({required this.id, required this.raw});

  factory SignUpPageViewDto.fromJson(Map<String, dynamic> json) {
    return SignUpPageViewDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
