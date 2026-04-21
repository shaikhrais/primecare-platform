// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hr_forms_data.freezed.dart';
part 'hr_forms_data.g.dart';

@freezed
abstract class HrFormsData with _$HrFormsData {
  const HrFormsData._();
  const factory HrFormsData({required Map<String, dynamic> metrics}) =
      _HrFormsData;

  factory HrFormsData.fromJson(Map<String, dynamic> json) =>
      _$HrFormsDataFromJson(json);

  factory HrFormsData.mock() => const HrFormsData(metrics: {});
}
