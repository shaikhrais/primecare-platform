// Layer: 02_MODELS_FOUNDATION
class InitializeFirebaseDto {
  final String id;
  final Map<String, dynamic> raw;

  InitializeFirebaseDto({required this.id, required this.raw});

  factory InitializeFirebaseDto.fromJson(Map<String, dynamic> json) {
    return InitializeFirebaseDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

