// Layer: 02_MODELS_FOUNDATION
class RolePermissionsFormDto {
  final String id;
  final Map<String, dynamic> raw;

  RolePermissionsFormDto({required this.id, required this.raw});

  factory RolePermissionsFormDto.fromJson(Map<String, dynamic> json) {
    return RolePermissionsFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
