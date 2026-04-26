// Layer: 02_MODELS_FOUNDATION
class FuseShortcutsDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseShortcutsDto({required this.id, required this.raw});

  factory FuseShortcutsDto.fromJson(Map<String, dynamic> json) {
    return FuseShortcutsDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
