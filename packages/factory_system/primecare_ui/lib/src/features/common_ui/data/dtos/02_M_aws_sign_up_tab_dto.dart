// Layer: 02_MODELS_FOUNDATION
class AwsSignUpTabDto {
  final String id;
  final Map<String, dynamic> raw;

  AwsSignUpTabDto({required this.id, required this.raw});

  factory AwsSignUpTabDto.fromJson(Map<String, dynamic> json) {
    return AwsSignUpTabDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
