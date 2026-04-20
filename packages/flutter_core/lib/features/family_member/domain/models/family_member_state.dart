import 'package:freezed_annotation/freezed_annotation.dart';
import 'family_member_data.dart';

part 'family_member_state.freezed.dart';

@freezed
abstract class FamilyMemberState with _$FamilyMemberState {
  const factory FamilyMemberState.initial() = _Initial;
  const factory FamilyMemberState.loading() = _Loading;
  const factory FamilyMemberState.loaded({required FamilyMemberData data}) =
      _Loaded;
  const factory FamilyMemberState.error(String message) = _Error;
}
