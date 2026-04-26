// Layer: 02_MODELS_FOUNDATION
class RoutesConfigDto {
  final String id;
  final Map<String, dynamic> raw;

  RoutesConfigDto({required this.id, required this.raw});

  factory RoutesConfigDto.fromJson(Map<String, dynamic> json) {
    return RoutesConfigDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
