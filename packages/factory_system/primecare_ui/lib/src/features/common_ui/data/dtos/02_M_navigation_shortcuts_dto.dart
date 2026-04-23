// Layer: 02_MODELS_FOUNDATION
class NavigationShortcutsDto {
  final String id;
  final Map<String, dynamic> raw;

  NavigationShortcutsDto({required this.id, required this.raw});

  factory NavigationShortcutsDto.fromJson(Map<String, dynamic> json) {
    return NavigationShortcutsDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

