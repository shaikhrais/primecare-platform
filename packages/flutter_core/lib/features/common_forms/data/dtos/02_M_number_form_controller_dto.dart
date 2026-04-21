// Layer: 02_MODELS_FOUNDATION
class NumberFormControllerDto {
  final String id;
  final Map<String, dynamic> raw;

  NumberFormControllerDto({required this.id, required this.raw});

  factory NumberFormControllerDto.fromJson(Map<String, dynamic> json) {
    return NumberFormControllerDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

