// Layer: 02_MODELS_FOUNDATION
class PoweredByLinksDto {
  final String id;
  final Map<String, dynamic> raw;

  PoweredByLinksDto({required this.id, required this.raw});

  factory PoweredByLinksDto.fromJson(Map<String, dynamic> json) {
    return PoweredByLinksDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
