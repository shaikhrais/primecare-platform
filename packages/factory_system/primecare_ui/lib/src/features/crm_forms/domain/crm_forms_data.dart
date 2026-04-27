// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crm_forms_data.freezed.dart';
part 'crm_forms_data.g.dart';

@freezed
abstract class CrmFormsData with _$CrmFormsData {
  const factory CrmFormsData({required Map<String, dynamic> metrics}) =
      _CrmFormsData;

  factory CrmFormsData.fromJson(Map<String, dynamic> json) =>
      _$CrmFormsDataFromJson(json);

  factory CrmFormsData.mock() => const CrmFormsData(metrics: {});
}
