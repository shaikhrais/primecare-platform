// Layer: 02_MODELS_FOUNDATION
class Error401PageViewDto {
  final String id;
  final Map<String, dynamic> raw;

  Error401PageViewDto({required this.id, required this.raw});

  factory Error401PageViewDto.fromJson(Map<String, dynamic> json) {
    return Error401PageViewDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
