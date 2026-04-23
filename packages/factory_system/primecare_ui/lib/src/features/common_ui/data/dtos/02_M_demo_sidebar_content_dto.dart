// Layer: 02_MODELS_FOUNDATION
class DemoSidebarContentDto {
  final String id;
  final Map<String, dynamic> raw;

  DemoSidebarContentDto({required this.id, required this.raw});

  factory DemoSidebarContentDto.fromJson(Map<String, dynamic> json) {
    return DemoSidebarContentDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

