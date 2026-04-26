// Layer: 02_MODELS_FOUNDATION
class WithRouterDto {
  final String id;
  final Map<String, dynamic> raw;

  WithRouterDto({required this.id, required this.raw});

  factory WithRouterDto.fromJson(Map<String, dynamic> json) {
    return WithRouterDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
