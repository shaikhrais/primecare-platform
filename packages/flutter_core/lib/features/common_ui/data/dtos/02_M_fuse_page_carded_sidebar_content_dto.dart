// Layer: 02_MODELS_FOUNDATION
class FusePageCardedSidebarContentDto {
  final String id;
  final Map<String, dynamic> raw;

  FusePageCardedSidebarContentDto({required this.id, required this.raw});

  factory FusePageCardedSidebarContentDto.fromJson(Map<String, dynamic> json) {
    return FusePageCardedSidebarContentDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

