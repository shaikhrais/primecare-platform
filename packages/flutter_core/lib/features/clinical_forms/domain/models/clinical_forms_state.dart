import 'package:freezed_annotation/freezed_annotation.dart';
import 'clinical_forms_data.dart';

part 'clinical_forms_state.freezed.dart';

@freezed
abstract class ClinicalFormsState with _$ClinicalFormsState {
  const factory ClinicalFormsState.initial() = _Initial;
  const factory ClinicalFormsState.loading() = _Loading;
  const factory ClinicalFormsState.loaded({required ClinicalFormsData data}) =
      _Loaded;
  const factory ClinicalFormsState.error(String message) = _Error;
}
