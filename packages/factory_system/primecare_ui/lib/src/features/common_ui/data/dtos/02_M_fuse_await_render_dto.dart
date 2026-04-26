// Layer: 02_MODELS_FOUNDATION
class FuseAwaitRenderDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseAwaitRenderDto({required this.id, required this.raw});

  factory FuseAwaitRenderDto.fromJson(Map<String, dynamic> json) {
    return FuseAwaitRenderDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
