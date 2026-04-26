// Layer: 02_MODELS_FOUNDATION
class NavigationDto {
  final String id;
  final Map<String, dynamic> raw;

  NavigationDto({required this.id, required this.raw});

  factory NavigationDto.fromJson(Map<String, dynamic> json) {
    return NavigationDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
