// Layer: 02_MODELS_FOUNDATION
class FusePageSimpleSidebarContentDto {
  final String id;
  final Map<String, dynamic> raw;

  FusePageSimpleSidebarContentDto({required this.id, required this.raw});

  factory FusePageSimpleSidebarContentDto.fromJson(Map<String, dynamic> json) {
    return FusePageSimpleSidebarContentDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

