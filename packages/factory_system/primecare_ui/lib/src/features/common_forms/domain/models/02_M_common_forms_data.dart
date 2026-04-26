// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_common_forms_data.freezed.dart';
part '02_M_common_forms_data.g.dart';

@freezed
abstract class CommonFormsData with _$CommonFormsData {
  const factory CommonFormsData({required Map<String, dynamic> metrics}) =
      _CommonFormsData;

  factory CommonFormsData.fromJson(Map<String, dynamic> json) =>
      _$CommonFormsDataFromJson(json);

  factory CommonFormsData.mock() => const CommonFormsData(metrics: {});
}
