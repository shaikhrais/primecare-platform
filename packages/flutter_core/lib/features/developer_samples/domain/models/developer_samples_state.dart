import 'package:freezed_annotation/freezed_annotation.dart';
import 'developer_samples_data.dart';

part 'developer_samples_state.freezed.dart';

@freezed
abstract class DeveloperSamplesState with _$DeveloperSamplesState {
  const factory DeveloperSamplesState.initial() = _Initial;
  const factory DeveloperSamplesState.loading() = _Loading;
  const factory DeveloperSamplesState.loaded({
    required DeveloperSamplesData data,
  }) = _Loaded;
  const factory DeveloperSamplesState.error(String message) = _Error;
}
