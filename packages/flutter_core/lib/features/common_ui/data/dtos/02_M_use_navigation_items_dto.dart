// Layer: 02_MODELS_FOUNDATION
class UseNavigationItemsDto {
  final String id;
  final Map<String, dynamic> raw;

  UseNavigationItemsDto({required this.id, required this.raw});

  factory UseNavigationItemsDto.fromJson(Map<String, dynamic> json) {
    return UseNavigationItemsDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

