// Layer: 02_MODELS_FOUNDATION
class MfaScreenDto {
  final String id;
  final Map<String, dynamic> raw;

  MfaScreenDto({required this.id, required this.raw});

  factory MfaScreenDto.fromJson(Map<String, dynamic> json) {
    return MfaScreenDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

