// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import 'common_forms_data.dart';

part 'common_forms_state.freezed.dart';

@freezed
abstract class CommonFormsState with _$CommonFormsState {
  const factory CommonFormsState.initial() = _Initial;
  const factory CommonFormsState.loading() = _Loading;
  const factory CommonFormsState.loaded({required CommonFormsData data}) =
      _Loaded;
  const factory CommonFormsState.error(String message) = _Error;
}
