// Layer: 02_MODELS_FOUNDATION
class AWSAuthContextDto {
  final String id;
  final Map<String, dynamic> raw;

  AWSAuthContextDto({required this.id, required this.raw});

  factory AWSAuthContextDto.fromJson(Map<String, dynamic> json) {
    return AWSAuthContextDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
