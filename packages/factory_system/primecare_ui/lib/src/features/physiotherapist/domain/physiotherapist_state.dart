// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import 'physiotherapist_data.dart';

part 'physiotherapist_state.freezed.dart';

@freezed
abstract class PhysiotherapistState with _$PhysiotherapistState {
  const factory PhysiotherapistState.initial() = _Initial;
  const factory PhysiotherapistState.loading() = _Loading;
  const factory PhysiotherapistState.loaded({
    required PhysiotherapistData data,
  }) = _Loaded;
  const factory PhysiotherapistState.error(String message) = _Error;
}
