// Layer: 02_MODELS_FOUNDATION
class LogInventorySpoilageFormDto {
  final String id;
  final Map<String, dynamic> raw;

  LogInventorySpoilageFormDto({required this.id, required this.raw});

  factory LogInventorySpoilageFormDto.fromJson(Map<String, dynamic> json) {
    return LogInventorySpoilageFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
