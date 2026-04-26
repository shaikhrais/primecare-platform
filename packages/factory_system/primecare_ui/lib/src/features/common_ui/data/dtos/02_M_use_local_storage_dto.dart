// Layer: 02_MODELS_FOUNDATION
class UseLocalStorageDto {
  final String id;
  final Map<String, dynamic> raw;

  UseLocalStorageDto({required this.id, required this.raw});

  factory UseLocalStorageDto.fromJson(Map<String, dynamic> json) {
    return UseLocalStorageDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
