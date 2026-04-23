// Layer: 02_MODELS_FOUNDATION
class BlockQuoteIconDto {
  final String id;
  final Map<String, dynamic> raw;

  BlockQuoteIconDto({required this.id, required this.raw});

  factory BlockQuoteIconDto.fromJson(Map<String, dynamic> json) {
    return BlockQuoteIconDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

