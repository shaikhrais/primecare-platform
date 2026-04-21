// Layer: 02_MODELS_FOUNDATION
class CreateCannedResponseFormDto {
  final String id;
  final Map<String, dynamic> raw;

  CreateCannedResponseFormDto({required this.id, required this.raw});

  factory CreateCannedResponseFormDto.fromJson(Map<String, dynamic> json) {
    return CreateCannedResponseFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

