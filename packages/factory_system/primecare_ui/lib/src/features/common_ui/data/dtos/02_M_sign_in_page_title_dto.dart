// Layer: 02_MODELS_FOUNDATION
class SignInPageTitleDto {
  final String id;
  final Map<String, dynamic> raw;

  SignInPageTitleDto({required this.id, required this.raw});

  factory SignInPageTitleDto.fromJson(Map<String, dynamic> json) {
    return SignInPageTitleDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

