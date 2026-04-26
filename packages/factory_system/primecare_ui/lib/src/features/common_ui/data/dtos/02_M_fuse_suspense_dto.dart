// Layer: 02_MODELS_FOUNDATION
class FuseSuspenseDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseSuspenseDto({required this.id, required this.raw});

  factory FuseSuspenseDto.fromJson(Map<String, dynamic> json) {
    return FuseSuspenseDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
