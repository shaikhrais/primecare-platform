// Layer: 02_MODELS_FOUNDATION
class ErrorBoundaryDto {
  final String id;
  final Map<String, dynamic> raw;

  ErrorBoundaryDto({required this.id, required this.raw});

  factory ErrorBoundaryDto.fromJson(Map<String, dynamic> json) {
    return ErrorBoundaryDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

