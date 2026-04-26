// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import '02_M_crm_forms_data.dart';

part '02_M_crm_forms_state.freezed.dart';

@freezed
abstract class CrmFormsState with _$CrmFormsState {
  const factory CrmFormsState.initial() = _Initial;
  const factory CrmFormsState.loading() = _Loading;
  const factory CrmFormsState.loaded({required CrmFormsData data}) = _Loaded;
  const factory CrmFormsState.error(String message) = _Error;
}
