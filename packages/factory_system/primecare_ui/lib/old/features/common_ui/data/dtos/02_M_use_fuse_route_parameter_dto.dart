// Layer: 02_MODELS_FOUNDATION
class UseFuseRouteParameterDto {
  final String id;
  final Map<String, dynamic> raw;

  UseFuseRouteParameterDto({required this.id, required this.raw});

  factory UseFuseRouteParameterDto.fromJson(Map<String, dynamic> json) {
    return UseFuseRouteParameterDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
