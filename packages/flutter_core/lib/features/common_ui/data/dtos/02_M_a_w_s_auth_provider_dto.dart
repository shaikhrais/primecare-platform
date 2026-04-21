// Layer: 02_MODELS_FOUNDATION
class AWSAuthProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  AWSAuthProviderDto({required this.id, required this.raw});

  factory AWSAuthProviderDto.fromJson(Map<String, dynamic> json) {
    return AWSAuthProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

