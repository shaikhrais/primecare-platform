// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part 'franchise_owner_data.freezed.dart';
part 'franchise_owner_data.g.dart';

@freezed
abstract class FranchiseOwnerData with _$FranchiseOwnerData {
  const FranchiseOwnerData._();
  const factory FranchiseOwnerData({required Map<String, dynamic> metrics}) =
      _FranchiseOwnerData;

  factory FranchiseOwnerData.fromJson(Map<String, dynamic> json) =>
      _$FranchiseOwnerDataFromJson(json);

  factory FranchiseOwnerData.mock() => const FranchiseOwnerData(metrics: {});
}
