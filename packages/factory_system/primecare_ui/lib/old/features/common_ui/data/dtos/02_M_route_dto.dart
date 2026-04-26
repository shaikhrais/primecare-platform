// Layer: 02_MODELS_FOUNDATION
class RouteDto {
  final String id;
  final Map<String, dynamic> raw;

  RouteDto({required this.id, required this.raw});

  factory RouteDto.fromJson(Map<String, dynamic> json) {
    return RouteDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
