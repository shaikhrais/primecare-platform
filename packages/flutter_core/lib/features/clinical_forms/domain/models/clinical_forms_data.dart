import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinical_forms_data.freezed.dart';
part 'clinical_forms_data.g.dart';

@freezed
abstract class ClinicalFormsData with _$ClinicalFormsData {
  const ClinicalFormsData._();
  const factory ClinicalFormsData({required Map<String, dynamic> metrics}) =
      _ClinicalFormsData;

  factory ClinicalFormsData.fromJson(Map<String, dynamic> json) =>
      _$ClinicalFormsDataFromJson(json);

  factory ClinicalFormsData.mock() => const ClinicalFormsData(metrics: {});
}
