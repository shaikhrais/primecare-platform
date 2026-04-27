// Layer: 02_MODELS_FOUNDATION
class UseAwsAuthDto {
  final String id;
  final Map<String, dynamic> raw;

  UseAwsAuthDto({required this.id, required this.raw});

  factory UseAwsAuthDto.fromJson(Map<String, dynamic> json) {
    return UseAwsAuthDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
