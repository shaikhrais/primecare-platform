// Layer: 02_MODELS_FOUNDATION
class ExternalLinkIconDto {
  final String id;
  final Map<String, dynamic> raw;

  ExternalLinkIconDto({required this.id, required this.raw});

  factory ExternalLinkIconDto.fromJson(Map<String, dynamic> json) {
    return ExternalLinkIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

