// Layer: 02_MODELS_FOUNDATION
class ForgotPasswordScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  ForgotPasswordScreenDto({required this.id, required this.raw});

  factory ForgotPasswordScreenDto.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

