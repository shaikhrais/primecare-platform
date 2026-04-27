// Layer: 02_MODELS_FOUNDATION
class PageBreadcrumbDto {
  final String id;
  final Map<String, dynamic> raw;

  PageBreadcrumbDto({required this.id, required this.raw});

  factory PageBreadcrumbDto.fromJson(Map<String, dynamic> json) {
    return PageBreadcrumbDto(id: json['id']?.toString() ?? '', raw: json);
  }
}
