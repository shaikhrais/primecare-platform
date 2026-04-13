import '../../domain/models/daily_vitals_card_form_view_model.dart';
import '../dtos/daily_vitals_card_form_dto.dart';

class DailyVitalsCardFormMapper {
  static DailyVitalsCardFormViewModel fromDto(DailyVitalsCardFormDto dto) {
    return DailyVitalsCardFormViewModel(
      recordId: dto.id ?? '',
      patientId: dto.patientId ?? '',
      temperature: dto.temperature?.toDouble() ?? 37.0,
      heartRate: dto.heartRate ?? 0,
      bloodPressureSystolic: dto.bloodPressureSystolic ?? 120,
      bloodPressureDiastolic: dto.bloodPressureDiastolic ?? 80,
      oxygenSaturation: dto.oxygenSaturation ?? 98,
      recordedAt: dto.recordedAt != null ? DateTime.tryParse(dto.recordedAt!) : null,
    );
  }

  static DailyVitalsCardFormDto toDto(DailyVitalsCardFormViewModel model) {
    return DailyVitalsCardFormDto(
      id: model.recordId.isEmpty ? null : model.recordId,
      patientId: model.patientId,
      temperature: model.temperature,
      heartRate: model.heartRate,
      bloodPressureSystolic: model.bloodPressureSystolic,
      bloodPressureDiastolic: model.bloodPressureDiastolic,
      oxygenSaturation: model.oxygenSaturation,
      recordedAt: model.recordedAt?.toIso8601String(),
    );
  }
}
