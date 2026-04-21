// Layer: 02_MODELS_FOUNDATION
class ScheduleFacilityMaintenanceFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ScheduleFacilityMaintenanceFormDto({required this.id, required this.raw});

  factory ScheduleFacilityMaintenanceFormDto.fromJson(Map<String, dynamic> json) {
    return ScheduleFacilityMaintenanceFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

