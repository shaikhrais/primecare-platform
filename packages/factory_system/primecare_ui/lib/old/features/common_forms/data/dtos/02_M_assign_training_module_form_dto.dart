// Layer: 02_MODELS_FOUNDATION
class AssignTrainingModuleFormDto {
  final String id;
  final Map<String, dynamic> raw;

  AssignTrainingModuleFormDto({required this.id, required this.raw});

  factory AssignTrainingModuleFormDto.fromJson(Map<String, dynamic> json) {
    return AssignTrainingModuleFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
