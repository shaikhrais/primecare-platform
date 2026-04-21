// Layer: 02_MODELS_FOUNDATION
class SignOutPageViewDto {
  final String id;
  final Map<String, dynamic> raw;

  SignOutPageViewDto({required this.id, required this.raw});

  factory SignOutPageViewDto.fromJson(Map<String, dynamic> json) {
    return SignOutPageViewDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

