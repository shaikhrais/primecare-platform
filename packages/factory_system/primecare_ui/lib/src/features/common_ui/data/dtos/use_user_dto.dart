// Layer: 02_MODELS_FOUNDATION
class UseUserDto {
  final String id;
  final Map<String, dynamic> raw;

  UseUserDto({required this.id, required this.raw});

  factory UseUserDto.fromJson(Map<String, dynamic> json) {
    return UseUserDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
