// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import '02_M_intake_coordinator_data.dart';

part '02_M_intake_coordinator_state.freezed.dart';

@freezed
abstract class IntakeCoordinatorState with _$IntakeCoordinatorState {
  const factory IntakeCoordinatorState.initial() = _Initial;
  const factory IntakeCoordinatorState.loading() = _Loading;
  const factory IntakeCoordinatorState.loaded({
    required IntakeCoordinatorData data,
  }) = _Loaded;
  const factory IntakeCoordinatorState.error(String message) = _Error;
}
