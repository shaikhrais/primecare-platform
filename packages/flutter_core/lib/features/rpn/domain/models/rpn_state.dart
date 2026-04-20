import 'package:freezed_annotation/freezed_annotation.dart';
import 'rpn_data.dart';

part 'rpn_state.freezed.dart';

@freezed
abstract class RpnState with _$RpnState {
  const factory RpnState.initial() = _Initial;
  const factory RpnState.loading() = _Loading;
  const factory RpnState.loaded({required RpnData data}) = _Loaded;
  const factory RpnState.error(String message) = _Error;
}
