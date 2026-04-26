// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import '02_M_physiotherapist_data.dart';

part '02_M_physiotherapist_state.freezed.dart';

@freezed
abstract class PhysiotherapistState with _$PhysiotherapistState {
  const factory PhysiotherapistState.initial() = _Initial;
  const factory PhysiotherapistState.loading() = _Loading;
  const factory PhysiotherapistState.loaded({
    required PhysiotherapistData data,
  }) = _Loaded;
  const factory PhysiotherapistState.error(String message) = _Error;
}
