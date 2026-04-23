// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import '02_M_hr_forms_data.dart';

part '02_M_hr_forms_state.freezed.dart';

@freezed
abstract class HrFormsState with _$HrFormsState {
  const factory HrFormsState.initial() = _Initial;
  const factory HrFormsState.loading() = _Loading;
  const factory HrFormsState.loaded({required HrFormsData data}) = _Loaded;
  const factory HrFormsState.error(String message) = _Error;
}
