// Layer: 02_MODELS_FOUNDATION
class FusePageCardedSidebarDto {
  final String id;
  final Map<String, dynamic> raw;

  FusePageCardedSidebarDto({required this.id, required this.raw});

  factory FusePageCardedSidebarDto.fromJson(Map<String, dynamic> json) {
    return FusePageCardedSidebarDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
