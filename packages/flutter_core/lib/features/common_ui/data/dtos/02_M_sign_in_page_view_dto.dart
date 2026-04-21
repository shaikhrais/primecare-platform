// Layer: 02_MODELS_FOUNDATION
class SignInPageViewDto {
  final String id;
  final Map<String, dynamic> raw;

  SignInPageViewDto({required this.id, required this.raw});

  factory SignInPageViewDto.fromJson(Map<String, dynamic> json) {
    return SignInPageViewDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

