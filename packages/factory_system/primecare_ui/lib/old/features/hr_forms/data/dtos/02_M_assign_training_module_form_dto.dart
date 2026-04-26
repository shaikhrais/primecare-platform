// Layer: 02_MODELS_FOUNDATION
class AssignTrainingModuleFormDto {
  final Map<String, dynamic> rawData;

  AssignTrainingModuleFormDto({required this.rawData});

  factory AssignTrainingModuleFormDto.fromJson(Map<String, dynamic> json) {
    return AssignTrainingModuleFormDto(rawData: json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }
}
