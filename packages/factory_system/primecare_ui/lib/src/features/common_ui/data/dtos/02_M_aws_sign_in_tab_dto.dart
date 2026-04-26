// Layer: 02_MODELS_FOUNDATION
class AwsSignInTabDto {
  final String id;
  final Map<String, dynamic> raw;

  AwsSignInTabDto({required this.id, required this.raw});

  factory AwsSignInTabDto.fromJson(Map<String, dynamic> json) {
    return AwsSignInTabDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
