// Layer: 02_MODELS_FOUNDATION
class SignupScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  SignupScreenDto({required this.id, required this.raw});

  factory SignupScreenDto.fromJson(Map<String, dynamic> json) {
    return SignupScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

