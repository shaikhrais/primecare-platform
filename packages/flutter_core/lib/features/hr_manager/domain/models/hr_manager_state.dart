import 'package:freezed_annotation/freezed_annotation.dart';
import 'hr_manager_data.dart';

part 'hr_manager_state.freezed.dart';

@freezed
abstract class HrManagerState with _$HrManagerState {
  const factory HrManagerState.initial() = _Initial;
  const factory HrManagerState.loading() = _Loading;
  const factory HrManagerState.loaded({required HrManagerData data}) = _Loaded;
  const factory HrManagerState.error(String message) = _Error;
}
