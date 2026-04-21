// Layer: 02_MODELS_FOUNDATION
class FuseAuthProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  FuseAuthProviderDto({required this.id, required this.raw});

  factory FuseAuthProviderDto.fromJson(Map<String, dynamic> json) {
    return FuseAuthProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

