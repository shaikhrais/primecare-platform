import 'package:freezed_annotation/freezed_annotation.dart';
import 'local_marketing_data.dart';

part 'local_marketing_state.freezed.dart';

@freezed
abstract class LocalMarketingState with _$LocalMarketingState {
  const factory LocalMarketingState.initial() = _Initial;
  const factory LocalMarketingState.loading() = _Loading;
  const factory LocalMarketingState.loaded({required LocalMarketingData data}) =
      _Loaded;
  const factory LocalMarketingState.error(String message) = _Error;
}
