// Layer: 02_MODELS_FOUNDATION
class SignInPageFormDto {
  final String id;
  final Map<String, dynamic> raw;

  SignInPageFormDto({required this.id, required this.raw});

  factory SignInPageFormDto.fromJson(Map<String, dynamic> json) {
    return SignInPageFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

