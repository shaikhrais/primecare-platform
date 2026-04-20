import 'package:freezed_annotation/freezed_annotation.dart';
import 'administrative_forms_data.dart';

part 'administrative_forms_state.freezed.dart';

@freezed
abstract class AdministrativeFormsState with _$AdministrativeFormsState {
  const factory AdministrativeFormsState.initial() = _Initial;
  const factory AdministrativeFormsState.loading() = _Loading;
  const factory AdministrativeFormsState.loaded({
    required AdministrativeFormsData data,
  }) = _Loaded;
  const factory AdministrativeFormsState.error(String message) = _Error;
}
