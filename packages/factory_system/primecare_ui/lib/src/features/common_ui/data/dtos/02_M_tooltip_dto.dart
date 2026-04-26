// Layer: 02_MODELS_FOUNDATION
class TooltipDto {
  final String id;
  final Map<String, dynamic> raw;

  TooltipDto({required this.id, required this.raw});

  factory TooltipDto.fromJson(Map<String, dynamic> json) {
    return TooltipDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
