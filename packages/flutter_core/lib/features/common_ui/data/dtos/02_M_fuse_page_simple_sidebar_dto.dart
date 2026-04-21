// Layer: 02_MODELS_FOUNDATION
class FusePageSimpleSidebarDto {
  final String id;
  final Map<String, dynamic> raw;

  FusePageSimpleSidebarDto({required this.id, required this.raw});

  factory FusePageSimpleSidebarDto.fromJson(Map<String, dynamic> json) {
    return FusePageSimpleSidebarDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

