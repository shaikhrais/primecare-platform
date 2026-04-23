// Layer: 02_MODELS_FOUNDATION
class ReviewFleetMaintenanceFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ReviewFleetMaintenanceFormDto({required this.id, required this.raw});

  factory ReviewFleetMaintenanceFormDto.fromJson(Map<String, dynamic> json) {
    return ReviewFleetMaintenanceFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}

