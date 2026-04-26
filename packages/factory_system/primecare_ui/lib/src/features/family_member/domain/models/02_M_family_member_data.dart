// Layer: 02_MODELS_FOUNDATION
import 'package:freezed_annotation/freezed_annotation.dart';

part '02_M_family_member_data.freezed.dart';
part '02_M_family_member_data.g.dart';

@freezed
abstract class FamilyMemberData with _$FamilyMemberData {
  const factory FamilyMemberData({required Map<String, dynamic> metrics}) =
      _FamilyMemberData;

  factory FamilyMemberData.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberDataFromJson(json);

  factory FamilyMemberData.mock() => const FamilyMemberData(metrics: {});
}
