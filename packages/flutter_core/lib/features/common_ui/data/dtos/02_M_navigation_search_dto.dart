// Layer: 02_MODELS_FOUNDATION
class NavigationSearchDto {
  final String id;
  final Map<String, dynamic> raw;

  NavigationSearchDto({required this.id, required this.raw});

  factory NavigationSearchDto.fromJson(Map<String, dynamic> json) {
    return NavigationSearchDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

