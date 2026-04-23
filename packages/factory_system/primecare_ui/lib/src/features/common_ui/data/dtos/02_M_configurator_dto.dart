// Layer: 02_MODELS_FOUNDATION
class ConfiguratorDto {
  final String id;
  final Map<String, dynamic> raw;

  ConfiguratorDto({required this.id, required this.raw});

  factory ConfiguratorDto.fromJson(Map<String, dynamic> json) {
    return ConfiguratorDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

