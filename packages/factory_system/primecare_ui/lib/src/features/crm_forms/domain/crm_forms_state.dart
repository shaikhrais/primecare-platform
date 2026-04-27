// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import 'crm_forms_data.dart';

part 'crm_forms_state.freezed.dart';

@freezed
abstract class CrmFormsState with _$CrmFormsState {
  const factory CrmFormsState.initial() = _Initial;
  const factory CrmFormsState.loading() = _Loading;
  const factory CrmFormsState.loaded({required CrmFormsData data}) = _Loaded;
  const factory CrmFormsState.error(String message) = _Error;
}
