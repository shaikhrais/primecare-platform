// Layer: 02_MODELS_FOUNDATION
class ButtonDto {
  final String id;
  final Map<String, dynamic> raw;

  ButtonDto({required this.id, required this.raw});

  factory ButtonDto.fromJson(Map<String, dynamic> json) {
    return ButtonDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

