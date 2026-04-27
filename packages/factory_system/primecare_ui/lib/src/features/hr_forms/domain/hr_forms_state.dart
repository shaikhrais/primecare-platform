// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import 'hr_forms_data.dart';

part 'hr_forms_state.freezed.dart';

@freezed
abstract class HrFormsState with _$HrFormsState {
  const factory HrFormsState.initial() = _Initial;
  const factory HrFormsState.loading() = _Loading;
  const factory HrFormsState.loaded({required HrFormsData data}) = _Loaded;
  const factory HrFormsState.error(String message) = _Error;
}
