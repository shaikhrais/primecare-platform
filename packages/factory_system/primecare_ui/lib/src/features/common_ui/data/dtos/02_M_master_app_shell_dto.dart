// Layer: 02_MODELS_FOUNDATION
class MasterAppShellDto {
  final String id;
  final Map<String, dynamic> raw;

  MasterAppShellDto({required this.id, required this.raw});

  factory MasterAppShellDto.fromJson(Map<String, dynamic> json) {
    return MasterAppShellDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
