// Layer: 02_MODELS_FOUNDATION
class ApprovePayrollRunFormDto {
  final String id;
  final Map<String, dynamic> raw;

  ApprovePayrollRunFormDto({required this.id, required this.raw});

  factory ApprovePayrollRunFormDto.fromJson(Map<String, dynamic> json) {
    return ApprovePayrollRunFormDto(
      id: json['id']?.toString() ?? '',
      raw: json,
    );
  }
}
