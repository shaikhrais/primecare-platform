// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import '02_M_system_verification_data.dart';

part '02_M_system_verification_state.freezed.dart';

@freezed
abstract class SystemVerificationState with _$SystemVerificationState {
  const factory SystemVerificationState.initial() = _Initial;
  const factory SystemVerificationState.loading() = _Loading;
  const factory SystemVerificationState.loaded({
    required SystemVerificationData data,
  }) = _Loaded;
  const factory SystemVerificationState.error(String message) = _Error;
}
