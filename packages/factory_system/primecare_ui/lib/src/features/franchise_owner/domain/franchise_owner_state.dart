// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';
import 'franchise_owner_data.dart';

part 'franchise_owner_state.freezed.dart';

@freezed
abstract class FranchiseOwnerState with _$FranchiseOwnerState {
  const factory FranchiseOwnerState.initial() = _Initial;
  const factory FranchiseOwnerState.loading() = _Loading;
  const factory FranchiseOwnerState.error(String message) = _Error;
  const factory FranchiseOwnerState.loaded({required FranchiseOwnerData data}) =
      _Loaded;
}
