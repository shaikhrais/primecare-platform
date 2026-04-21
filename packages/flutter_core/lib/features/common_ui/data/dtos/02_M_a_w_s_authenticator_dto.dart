// Layer: 02_MODELS_FOUNDATION
class AWSAuthenticatorDto {
  final String id;
  final Map<String, dynamic> raw;

  AWSAuthenticatorDto({required this.id, required this.raw});

  factory AWSAuthenticatorDto.fromJson(Map<String, dynamic> json) {
    return AWSAuthenticatorDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

