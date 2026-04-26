// Layer: 02_MODELS_FOUNDATION
class UseFirebaseAuthDto {
  final String id;
  final Map<String, dynamic> raw;

  UseFirebaseAuthDto({required this.id, required this.raw});

  factory UseFirebaseAuthDto.fromJson(Map<String, dynamic> json) {
    return UseFirebaseAuthDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
