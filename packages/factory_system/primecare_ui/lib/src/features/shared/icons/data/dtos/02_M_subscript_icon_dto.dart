// Layer: 02_MODELS_FOUNDATION
class SubscriptIconDto {
  final String id;
  final Map<String, dynamic> raw;

  SubscriptIconDto({required this.id, required this.raw});

  factory SubscriptIconDto.fromJson(Map<String, dynamic> json) {
    return SubscriptIconDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
