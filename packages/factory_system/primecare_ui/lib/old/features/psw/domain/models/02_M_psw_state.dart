// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import '02_M_psw_data.dart';

part '02_M_psw_state.freezed.dart';

@freezed
abstract class PswState with _$PswState {
  const factory PswState.initial() = _Initial;
  const factory PswState.loading() = _Loading;
  const factory PswState.loaded({required PswData data}) = _Loaded;
  const factory PswState.error(String message) = _Error;
}
