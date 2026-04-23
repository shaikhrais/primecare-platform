// Layer: 02_MODELS_FOUNDATION
class Error404PageViewDto {
  final String id;
  final Map<String, dynamic> raw;

  Error404PageViewDto({required this.id, required this.raw});

  factory Error404PageViewDto.fromJson(Map<String, dynamic> json) {
    return Error404PageViewDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

