// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import '02_M_rn_data.dart';

part '02_M_rn_state.freezed.dart';

@freezed
abstract class RnState with _$RnState {
  const factory RnState.initial() = _Initial;
  const factory RnState.loading() = _Loading;
  const factory RnState.loaded({required RnData data}) = _Loaded;
  const factory RnState.error(String message) = _Error;
}
