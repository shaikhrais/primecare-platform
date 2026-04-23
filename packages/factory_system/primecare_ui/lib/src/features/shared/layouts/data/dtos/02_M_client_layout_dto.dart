// Layer: 02_MODELS_FOUNDATION
class ClientLayoutDto {
  final String id;
  final Map<String, dynamic> raw;

  ClientLayoutDto({required this.id, required this.raw});

  factory ClientLayoutDto.fromJson(Map<String, dynamic> json) {
    return ClientLayoutDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

