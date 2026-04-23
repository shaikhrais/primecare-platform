// Layer: 02_MODELS_FOUNDATION
class WithUserDto {
  final String id;
  final Map<String, dynamic> raw;

  WithUserDto({required this.id, required this.raw});

  factory WithUserDto.fromJson(Map<String, dynamic> json) {
    return WithUserDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

