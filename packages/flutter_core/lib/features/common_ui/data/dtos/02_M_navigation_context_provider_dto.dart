// Layer: 02_MODELS_FOUNDATION
class NavigationContextProviderDto {
  final String id;
  final Map<String, dynamic> raw;

  NavigationContextProviderDto({required this.id, required this.raw});

  factory NavigationContextProviderDto.fromJson(Map<String, dynamic> json) {
    return NavigationContextProviderDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

