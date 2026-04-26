// Layer: 02_MODELS_FOUNDATION
class LogPettyCashFormDto {
  final String id;
  final Map<String, dynamic> raw;

  LogPettyCashFormDto({required this.id, required this.raw});

  factory LogPettyCashFormDto.fromJson(Map<String, dynamic> json) {
    return LogPettyCashFormDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
