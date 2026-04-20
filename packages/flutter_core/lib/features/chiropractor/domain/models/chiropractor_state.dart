import 'package:freezed_annotation/freezed_annotation.dart';
import 'chiropractor_data.dart';

part 'chiropractor_state.freezed.dart';

@freezed
abstract class ChiropractorState with _$ChiropractorState {
  const factory ChiropractorState.initial() = _Initial;
  const factory ChiropractorState.loading() = _Loading;
  const factory ChiropractorState.loaded({required ChiropractorData data}) =
      _Loaded;
  const factory ChiropractorState.error(String message) = _Error;
}
