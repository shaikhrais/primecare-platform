// Layer: 02_MODELS_FOUNDATION
class SignOutPageTitleDto {
  final String id;
  final Map<String, dynamic> raw;

  SignOutPageTitleDto({required this.id, required this.raw});

  factory SignOutPageTitleDto.fromJson(Map<String, dynamic> json) {
    return SignOutPageTitleDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
