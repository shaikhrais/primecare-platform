// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_administrative_forms_data.freezed.dart';
part '02_M_administrative_forms_data.g.dart';

@freezed
abstract class AdministrativeFormsData with _$AdministrativeFormsData {
  const factory AdministrativeFormsData({
    required Map<String, dynamic> metrics,
  }) = _AdministrativeFormsData;

  factory AdministrativeFormsData.fromJson(Map<String, dynamic> json) =>
      _$AdministrativeFormsDataFromJson(json);

  factory AdministrativeFormsData.mock() =>
      const AdministrativeFormsData(metrics: {});
}
