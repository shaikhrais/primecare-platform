import 'package:freezed_annotation/freezed_annotation.dart';
import 'rn_data.dart';

part 'rn_state.freezed.dart';

@freezed
abstract class RnState with _$RnState {
  const factory RnState.initial() = _Initial;
  const factory RnState.loading() = _Loading;
  const factory RnState.loaded({required RnData data}) = _Loaded;
  const factory RnState.error(String message) = _Error;
}
