import 'package:freezed_annotation/freezed_annotation.dart';
import 'guest_data.dart';

part 'guest_state.freezed.dart';

@freezed
abstract class GuestState with _$GuestState {
  const factory GuestState.initial() = _Initial;
  const factory GuestState.loading() = _Loading;
  const factory GuestState.loaded({required GuestData data}) = _Loaded;
  const factory GuestState.error(String message) = _Error;
}
