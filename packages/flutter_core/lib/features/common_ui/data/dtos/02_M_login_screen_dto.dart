// Layer: 02_MODELS_FOUNDATION
class LoginScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  LoginScreenDto({required this.id, required this.raw});

  factory LoginScreenDto.fromJson(Map<String, dynamic> json) {
    return LoginScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

