// Layer: 02_MODELS_FOUNDATION
class SignUpPageTitleDto {
  final String id;
  final Map<String, dynamic> raw;

  SignUpPageTitleDto({required this.id, required this.raw});

  factory SignUpPageTitleDto.fromJson(Map<String, dynamic> json) {
    return SignUpPageTitleDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
