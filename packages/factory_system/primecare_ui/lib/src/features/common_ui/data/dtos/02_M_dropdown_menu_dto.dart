// Layer: 02_MODELS_FOUNDATION
class DropdownMenuDto {
  final String id;
  final Map<String, dynamic> raw;

  DropdownMenuDto({required this.id, required this.raw});

  factory DropdownMenuDto.fromJson(Map<String, dynamic> json) {
    return DropdownMenuDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

