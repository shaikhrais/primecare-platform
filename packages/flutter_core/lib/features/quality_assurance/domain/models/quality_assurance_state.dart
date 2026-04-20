import 'package:freezed_annotation/freezed_annotation.dart';
import 'quality_assurance_data.dart';

part 'quality_assurance_state.freezed.dart';

@freezed
abstract class QualityAssuranceState with _$QualityAssuranceState {
  const factory QualityAssuranceState.initial() = _Initial;
  const factory QualityAssuranceState.loading() = _Loading;
  const factory QualityAssuranceState.loaded({
    required QualityAssuranceData data,
  }) = _Loaded;
  const factory QualityAssuranceState.error(String message) = _Error;
}
