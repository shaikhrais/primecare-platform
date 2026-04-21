// Layer: 02_MODELS_FOUNDATION
class UserMenuDto {
  final String id;
  final Map<String, dynamic> raw;

  UserMenuDto({required this.id, required this.raw});

  factory UserMenuDto.fromJson(Map<String, dynamic> json) {
    return UserMenuDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

