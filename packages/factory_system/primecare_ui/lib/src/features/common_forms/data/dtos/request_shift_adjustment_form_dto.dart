// Layer: 02_MODELS_FOUNDATION
class RequestShiftAdjustmentFormDto {
  final String id;
  final Map<String, dynamic> raw;

  RequestShiftAdjustmentFormDto({required this.id, required this.raw});

  factory RequestShiftAdjustmentFormDto.fromJson(Map<String, dynamic> json) {
    return RequestShiftAdjustmentFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
